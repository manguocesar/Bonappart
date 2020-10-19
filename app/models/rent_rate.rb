# frozen_string_literal: true

# RentRate model
class RentRate < ApplicationRecord
  # Associations
  belongs_to :apartment
end
