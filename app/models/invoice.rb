class Invoice < ApplicationRecord
  belongs_to :booking, optional: true
  belongs_to :subscription, optional: true

  # Validations
  validates_presence_of :invoice_number, :amount, :date

  # Status enum
  enum status: { unpaid: 0, paid: 1 }

  def apartment_rent
    booking.present? ? booking.rent_amount : subscription.subscription_amount
  end

  def apartment_title
    booking.present? ? booking.apartment_title : subscription.apartment_title
  end

  def start_date
    booking.present? ? booking.start_date : subscription.started_at
  end

  def end_date
    booking.present? ? booking.end_date : subscription.expired_at
  end

  def address
    booking.present? ? booking.payment_address : subscription.payment_address
  end
end
