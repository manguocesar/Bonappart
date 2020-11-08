# frozen_string_literal: true

# Apartment model
class Apartment < ApplicationRecord
  # scopes for filters
  scope :filter_by_type, ->(apartment_type) { joins(:apartment_type).where('apartment_types.name ILIKE :apartment_type', apartment_type: "%#{apartment_type.downcase}%") }
  scope :filter_by_distance_from_university, ->(distance_from_university) { where 'distance_from_university ILIKE ?', distance_from_university.downcase }
  scope :filter_by_rent_asc, -> { includes(:rent_rate).order('rent_rates.net_rate ASC') }
  scope :filter_by_rent, ->(low_rate, high_rate) { joins(:rent_rate).where('rent_rates.net_rate >= ? AND rent_rates.net_rate <= ?', low_rate, high_rate) }
  scope :filter_by_departure_date, ->(departure_date) { where departure_date:  DateTime.parse(departure_date) }
  scope :similar_apartments, ->(distance_from_university) { where distance_from_university: distance_from_university }

  # Associations
  has_many_attached :images
  belongs_to :user
  has_one :rent_rate, dependent: :destroy
  belongs_to :apartment_type
  belongs_to :booking, optional: true
  accepts_nested_attributes_for :rent_rate

  # Delegation
  delegate :phone_no, to: :user, prefix: :user

  # validates presence of fields
  validates_presence_of :title, :description, :postalcode, :floor,
                        :city, :country, :area, :apartment_type,
                        :departure_date,:total_bedrooms,
                        :shower_room, :other_facilities,
                        :distance_from_university

  geocoded_by :full_address
  after_validation :geocode # , if: ->(obj){ obj.address.present? and obj.address_changed? }

  # Set active class to first attachment
  def active_class(image)
    image == images.first ? 'active' : ''
  end

  # For apply geocoding using full address
  def full_address
    [country, city, area].compact.join(', ')
  end

  # departure date availabilty with date format
  def departure_date_availabilty
    departure_date&.strftime('%d-%m-%Y')
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
end
