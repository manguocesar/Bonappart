# frozen_string_literal: true

# Apartment model
class Apartment < ApplicationRecord
  has_many_attached :images
end
