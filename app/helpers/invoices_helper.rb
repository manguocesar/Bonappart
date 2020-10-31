# frozen_string_literal: true

# Invoices Helper
module InvoicesHelper
  def invoice_sumary_title(invoice)
    invoice.booking.present? ? t('invoice.booking_summary') : t('invoice.subscription_summary')
  end
end
