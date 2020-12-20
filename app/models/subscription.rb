# frozen_string_literal: true

# Subscription model
class Subscription < ApplicationRecord
  # scope for filter by status
  scope :filter_by_status, ->(status) { where status: status }
  scope :created_between, ->(start_date, end_date) {where("started_at >= ? AND started_at <= ?", start_date, end_date )}

  # Enums
  enum status: { pending: 0, failed: 1, paid: 2 }

  # Associations
  has_many :payments, dependent: :destroy
  has_one :invoice, dependent: :destroy
  belongs_to :user
  belongs_to :apartment

  def payment_address
    payments&.paid&.last&.address if payments.present?
  end

  def payment_type
    payments&.paid.last&.payment_type&.titleize
  end

  def payment_status
    payments&.last&.status if payments.present?
  end

  def apartment_title
    apartment&.title&.humanize
  end

  def subscription_amount
    apartment&.landlord_listing_fee
  end
end
