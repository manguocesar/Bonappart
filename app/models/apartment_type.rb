# Apartment Model
class ApartmentType < ApplicationRecord
  validates_presence_of :name, :amount
end
