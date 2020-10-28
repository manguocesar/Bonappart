# Apartment Model
class ApartmentType < ApplicationRecord
  has_one_attached :image

  validates_presence_of :name, :amount
end
