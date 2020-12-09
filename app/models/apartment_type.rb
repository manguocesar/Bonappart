# Apartment Model
class ApartmentType < ApplicationRecord
  has_many :apartments
  has_one_attached :image
  enum status: { active: 0, inactive: 1 }
  enum campus: { Fontainebleau: 0, Singapore: 1 }
  scope :fantainebleau_campus, -> { where(name: 'default', campus: 'Fontainebleau').first }
  scope :singapore_campus, -> { where(name: 'default', campus: 'Singapore').first }

  validates_presence_of :name, :landlord_listing_fee, :student_booking_fee

  def default
    name == 'default'
  end
end
