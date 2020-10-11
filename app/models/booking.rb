# frozen_string_literal: true

# Booking model
class Booking < ApplicationRecord
  has_many :payments
  # has_one :invoice
  belongs_to :user
  has_one :apartment
  enum status: { pending: 0, failed: 1, paid: 2}
end
