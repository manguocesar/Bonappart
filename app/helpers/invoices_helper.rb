# frozen_string_literal: true

# Invoices Helper
module InvoicesHelper
  def invoice_sumary_title(invoice)
    invoice.booking.present? ? t('invoice.booking_summary') : t('invoice.subscription_summary')
  end

  def invoice_payment_path(invoice)
    if invoice.booking.present?
      add_payment_method_path(booking_id: @invoice.booking&.id)
    else
      add_payment_method_path(subscription: @invoice.subscription&.id)
    end
  end
end
