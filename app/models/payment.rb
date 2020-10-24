# frozen_string_literal: true

# Payment model
class Payment < ApplicationRecord
  # Enums of status and payment type
  enum status: { pending: 0, failed: 1, paid: 2 }
  enum payment_type: { deposit: 0, full: 1 }

  # Assciations
  belongs_to :booking, optional: true
  belongs_to :subscription, optional: true
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  # Callbacks
  after_update :update_status, if: -> { saved_change_to_attribute?(:status) && paid? }

  # Update booking or subscription status when payment status is paid
  def update_status
    booking.present? ? booking.paid! : subscription.paid!
    if booking.present?
      booking.paid!
      booking.apartment.update(availability: false)
    else
      subscription.paid!
      subscription.apartment.update(subscribed: true)
    end
  end

  # Payment statuses dropdown
  def self.payment_statuses
    Payment.statuses.map { |k, v| [k.humanize.capitalize, k] }
  end
end
