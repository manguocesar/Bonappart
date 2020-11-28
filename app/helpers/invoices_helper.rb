# frozen_string_literal: true

# Invoices Helper
module InvoicesHelper
  def invoice_sumary_title(invoice)
    invoice.booking.present? ? t('invoice.booking_summary') : t('invoice.subscription_summary')
  end

  def invoice_payment_path(invoice)
    if invoice.booking.present?
      add_payment_method_path(booking_id: invoice.booking&.id, amount: invoice.amount)
    else
      add_payment_method_path(subscription: invoice.subscription&.id, amount: invoice.amount)
    end
  end

  def paid_amount(invoice)
    invoice.paid? ? invoice.amount : Constant::ZERO
  end

  def balance_due_amount(invoice)
    invoice.paid? ? Constant::ZERO : invoice.amount
  end

  def invoice_show_path(invoice)
    if current_user.present?
      if current_user.landlord?
        landlord_invoice_path(invoice)
      elsif current_user.admin?
        admin_invoice_path(invoice)
      else
        invoice_path(invoice)
      end
    end
  end

  def invoice_title
    current_user.landlord? ? t('post_confirmation') : t('booking_confirmation')
  end
end
