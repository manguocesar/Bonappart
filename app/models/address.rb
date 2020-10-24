# frozen_string_literal: true

# Address model
class Address < ApplicationRecord
  # Associations
  belongs_to :payment
end
