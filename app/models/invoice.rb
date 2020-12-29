class Invoice < ApplicationRecord
  belongs_to :booking, optional: true
  belongs_to :subscription, optional: true

  # Validations
  validates_presence_of :invoice_number, :amount, :date

  # Status enum
  enum status: { unpaid: 0, paid: 1 }

  # Scopes
  scope :paid_invoices, -> { where(status: 'paid') }

  def payment_amount
    booking.present? ? Constant::PAYMENT_AMOUNT : subscription.subscription_amount
  end

  def apartment_title
    booking.present? ? booking&.apartment_title : subscription&.apartment_title
  end

  def start_date
    booking.present? ? booking&.start_date : subscription&.started_at
  end

  def end_date
    booking.present? ? booking&.end_date : subscription&.expired_at
  end

  def address
    booking.present? ? booking&.payment_address : subscription&.payment_address
  end

  def landlord_user
    User.with_role(:landlord).map(&:fullname_with_id)
  end

  def total_amount
    vat_rate.present? ? amount + vat_rate : amount
  end

  def balance_due
    total_amount - amount
  end

  def generate_invoice_number
    invoice_number.present? ? invoice_number : random_invoice_number
  end

  def random_invoice_number
    rand.to_s[2, 8]
  end
end
