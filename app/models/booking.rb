# frozen_string_literal: true

# Booking model
class Booking < ApplicationRecord
  # Enums
  enum status: { pending: 0, failed: 1, paid: 2 }

  # Associations
  has_many :payments
  has_one :invoice
  belongs_to :user
  has_one :apartment

  def rent_amount
    apartment&.rent_rate&.net_rate
  end

  def apartment_title
    apartment&.title
  end

  def payment_address
    payments.paid.last.address
  end

  def payment_type
    payments.paid.last.payment_type.titleize
  end

  def payment_status
    payments.last.status
  end
end
