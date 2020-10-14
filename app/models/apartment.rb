# frozen_string_literal: true

# Apartment model
class Apartment < ApplicationRecord
  has_many_attached :images
  belongs_to :user

  # validates presence of fields
  validates_presence_of :title, :description, :postalcode, :floor,
						:city, :country, :area, :apartment_type,
						:departure_date,:total_bedrooms,
						:shower_room, :other_facilities,
						:distance_from_university, :longitude, :latitude

  geocoded_by :full_address
  after_validation :geocode # , if: ->(obj){ obj.address.present? and obj.address_changed? }

  scope :filter_by_type,-> (apartment_type) {where("apartment_type ILIKE :apartment_type", apartment_type: "%#{apartment_type.downcase}%") }
  scope :filter_by_distance_from_university, ->(distance_from_university) { where distance_from_university: distance_from_university }
  # scope :filter_by_rent, ->(rent) { where distance_from_university: rent } Update when rent model available
  scope :filter_by_arrival_date, ->(arrival_date) { where arrival_date: DateTime.parse(arrival_date) }
  scope :filter_by_departure_date, ->(departure_date) { where departure_date:  DateTime.parse(departure_date) }

  # Set active class to first attachment
  def active_class(image)
    image == images.first ? 'active' : ''
  end

  # For apply geocoding using full address
  def full_address
    [country, city, area].compact.join(', ')
  end
end
