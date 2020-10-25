# frozen_string_literal: true

# Booking model
class Booking < ApplicationRecord
  # Enums
  enum status: { pending: 0, failed: 1, paid: 2 }

  # Associations
  has_many :payments
  # has_one :invoice
  belongs_to :user
  has_one :apartment
end
