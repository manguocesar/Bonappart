# Apartment Model
class ApartmentType < ApplicationRecord
  has_many :apartments
  has_one_attached :image
  enum status: { active: 0, inactive: 1 }

  validates_presence_of :name, :amount
end
