# frozen_string_literal: true

# Apartment model
class Apartment < ApplicationRecord
  # scopes for filters
  scope :filter_by_type, ->(apartment_type) { joins(:apartment_type).where('apartment_types.name ILIKE :apartment_type', apartment_type: "%#{apartment_type.downcase}%") }
  scope :filter_by_distance_from_campus, ->(distance_from_campus) { where 'distance_from_campus ILIKE ?', distance_from_campus.downcase }
  scope :filter_by_campus, ->(campus) { where campus: campus }
  scope :filter_by_rent_asc, -> { includes(:rent_rate).order('rent_rates.net_rate ASC') }
  scope :filter_by_rent, ->(low_rate, high_rate) { joins(:rent_rate).where('rent_rates.net_rate >= ? AND rent_rates.net_rate <= ?', low_rate, high_rate) }
  scope :filter_by_month, ->(month) { where month: month }
  scope :filter_by_year, ->(year) { where year: year }
  scope :similar_apartments, ->(distance_from_campus) { where distance_from_campus: distance_from_campus }
  scope :subscribed, -> { where(subscribed: true) }
  scope :unsubscribed, -> { reject(&:subscribed) }
  scope :available, -> { where(availability: true) }
  scope :unavailable, -> { reject(&:availability) }

  # Associations
  has_many_attached :images
  belongs_to :user
  has_one :rent_rate, dependent: :destroy
  has_many :inquiries
  belongs_to :apartment_type
  belongs_to :booking, optional: true
  has_one :subscription, dependent: :destroy
  accepts_nested_attributes_for :rent_rate

  # Delegation
  delegate :phone_no, to: :user, prefix: :user

  # validates presence of fields
  validates_presence_of :title, :description, :postalcode, :floor,
                        :city, :area, :apartment_type, :total_bedrooms, :shower_room

  validate :maximum_image_uploadation

  geocoded_by :full_address
  after_validation :geocode # , if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_commit :walking_distance_from_campus, only: %i[create update]

  SINGAPORE = 'Singapore'.freeze

  def walking_distance_from_campus
    DistanceMatrixGoogleApiWorker.perform_async(self&.id) if api_call_validated?
  end

  def api_call_validated?
    (latitude.present? && longitude.present?) &&
      (distance_from_campus.blank? || duration_from_campus.blank?)
  end

  def maximum_image_uploadation
    errors.add(:base, 'maximum 20 images can allowed to upload') if images.count > 20
  end

  # Set active class to first attachment
  def active_class(image)
    image == images.first ? 'active' : ''
  end

  # For apply geocoding using full address
  def full_address
    [area, city, country].compact.join(', ')
  end

  # departure date availabilty with date format
  def departure_date_availabilty
    departure_date&.strftime('%d-%m-%Y')
  end

  def parse_date
    Date.parse("1-#{month}-#{year}")
  end

  def display_proper_availability_date
    parse_date&.strftime('%b, %Y') if month && year
  end

  # Check future date availability
  def available_in_future?
    parse_date > Date.today
  end

  # Display available date
  def available_date
    if available_in_future?
      "Available From #{display_proper_availability_date}"
    elsif booking.present?
      "Rented from #{booking.startdate} To #{booking.enddate}"
    else
      'Available Now'
    end
  end

  # landlord full name
  def landlord_name
    "#{user&.firstname} #{user&.lastname}"
  end

  # Booked apartment availability date
  def apartment_availability_date
    booking.end_date&.strftime('%d-%m-Y')
  end

  # For getting apartment type of apartment
  def apartment_type_name
    apartment_type&.name&.titleize
  end

  # Return net amount of apartment
  def net_rent
    rent_rate&.net_rate&.to_i if rent_rate.present?
  end

  # Other amenities details
  def other_amenities
    Constant::APARTMENT_OTHER_AMENITIES.map { |field| [field, send(field)] unless send(field).to_i.zero? }
  end

  # Full Address with floor no.
  def display_full_address
    [floor, full_address].join(' ')
  end

  # Get user image..
  def user_image
    user.image
  end

  def singapore?
    campus == 'Singapore'
  end

  # Get landlord's listing fee
  def landlord_listing_fee
    if campus == SINGAPORE
      ApartmentType.singapore_campus.landlord_listing_fee
    else
      ApartmentType.fantainebleau_campus.landlord_listing_fee
    end
  end

  # Check apartment subscription details
  def check_subscription
    !subscribed || subscription_present?
  end

  def subscription_present?
    return unless subscription

    subscription.expired_at.eql?(Date.today)
  end
end
