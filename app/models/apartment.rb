# frozen_string_literal: true

# Apartment model
class Apartment < ApplicationRecord
  has_many_attached :images

  geocoded_by :full_address
  after_validation :geocode#, if: ->(obj){ obj.address.present? and obj.address_changed? }

  def full_address
    [country, city, area].compact.join(', ')
  end
end
