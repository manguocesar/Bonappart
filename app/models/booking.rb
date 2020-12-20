# frozen_string_literal: true

# Booking model
class Booking < ApplicationRecord
  # scope for filter by status
  scope :filter_by_status, ->(status) { where status: status }
  scope :created_between, ->(start_date, end_date) { where("created_at >= ? AND created_at <= ?", start_date, end_date) }

  # Enums
  enum status: { pending: 0, failed: 1, paid: 2 }

  # Associations
  has_many :payments, dependent: :destroy
  has_one :invoice, dependent: :destroy
  belongs_to :user
  has_one :apartment

  def rent_amount
    apartment&.rent_rate&.net_rate
  end

  def apartment_title
    apartment&.title
  end

  def payment_address
    payments&.paid&.last&.address
  end

  def payment_type
    payments&.paid&.last&.payment_type&.titleize
  end

  def payment_status
    payments&.last&.status
  end

  def startdate
    start_date.strftime('%B %d, %Y') if start_date.present?
  end

  def enddate
    end_date.strftime('%B %d, %Y') if end_date.present?
  end
end
