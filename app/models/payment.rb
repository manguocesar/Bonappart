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
    if booking.present?
      update_apartment_status(Constant::BOOKING, Constant::AVAILABILITY, false)
    else
      update_apartment_status(Constant::SUBSCRIPTION, Constant::SUBSCRIBED, true)
    end
  end

  def update_apartment_status(model_name, field_name, value)
    send(model_name).paid!
    send(model_name).apartment.update_attribute(field_name, value)
    send(model_name).invoice.paid! if model_name == 'subscription'
  end

  # Payment statuses dropdown
  def self.payment_statuses
    statuses.map { |k, v| [k.humanize.capitalize, k] }
  end

  # Find the booked property
  def booked_apartment
    booking&.apartment
  end
end
