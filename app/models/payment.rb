# frozen_string_literal: true

# Payment model
class Payment < ApplicationRecord
  # Enums of status and payment type
  enum status: { pending: 0, failed: 1, paid: 2}
  enum payment_type: { deposit: 0, full: 1}

  # Assciations
  belongs_to :booking

  # Callbacks
  after_update :update_booking, if: -> { saved_change_to_attribute?(:status) && paid? }

  # Update booking status when payment status is paid
  def update_booking
    booking.paid!
  end

  # Payment statuses dropdown
  def self.payment_statuses
    Payment.statuses.map {|k, v| [k.humanize.capitalize, k]}
  end
end
