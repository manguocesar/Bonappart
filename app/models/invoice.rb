class Invoice < ApplicationRecord
  belongs_to :booking
  belongs_to :subscription

  # Validations
  validates_presence_of :invoice_number, :amount, :date

  # Status enum
  enum status: { unpaid: 0, paid: 1 }

  def apartment_rent
    booking.rent_amount
  end

  def apartment_title
    booking.apartment_title
  end

  def arrival
    booking.start_date
  end

  def departure
    booking.end_date
  end

  def address
    booking.present? ? booking.payment_address : subscription.payment_address
  end
end
