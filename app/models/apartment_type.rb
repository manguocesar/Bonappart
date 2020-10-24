# Apartment Model
class ApartmentType < ApplicationRecord
  has_many :apartments

  validates_presence_of :name, :amount
end
