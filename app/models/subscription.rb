# frozen_string_literal: true

# Subscription model
class Subscription < ApplicationRecord
  # Enums
  enum status: { pending: 0, failed: 1, paid: 2 }

  # Associations
  has_many :payments
  has_one :invoice
  belongs_to :user
  belongs_to :apartment

  def payment_address
    payments.paid.last.address
  end

  def payment_type
    payments.paid.last.payment_type.titleize
  end

  def payment_status
    payments.last.status
  end

  def apartment_title
    apartment&.title
  end

  def subscription_amount
    apartment.apartment_type.amount
  end
end
