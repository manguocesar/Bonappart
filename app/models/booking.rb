# frozen_string_literal: true

# Booking model
class Booking < ApplicationRecord
  # scope for filter by status
  scope :filter_by_status, ->(status) { where status: status }
  scope :created_between, ->(start_date, end_date) {where("created_at >= ? AND created_at <= ?", start_date, end_date )}

  # Enums
  enum status: { pending: 0, failed: 1, paid: 2}

  # Associations
  has_many :payments
  # has_one :invoice
  belongs_to :user
  has_one :apartment
end
