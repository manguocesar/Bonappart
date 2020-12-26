# Apartment Model
class ApartmentType < ApplicationRecord
  has_many :apartments
  has_one_attached :image
  enum status: { active: 0, inactive: 1 }
  enum campus: { Fontainebleau: 0, Singapore: 1 }
  scope :fontainebleau_campus, -> { where(campus: 'Fontainebleau', default_type: true).first }
  scope :singapore_campus, -> { where(campus: 'Singapore', default_type: true).first }

  validates_presence_of :name, :landlord_listing_fee, :student_booking_fee
end
