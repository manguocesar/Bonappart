# frozen_string_literal: true

# Apartment model
class Apartment < ApplicationRecord
  has_many_attached :images
  belongs_to :user

  # validates presence of fields
  validates_presence_of :title, :description, :postalcode, :floor,
						:city, :country, :area, :apartment_type,
						:arrival_date, :departure_date,:total_bedrooms,
						:shower_room, :other_facilities,
						:distance_from_university, :longitude, :latitude
end
