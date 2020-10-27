# Apartment Model
class ApartmentType < ApplicationRecord
  has_many :apartments
  has_one_attached :image

  validates_presence_of :name, :amount
end
