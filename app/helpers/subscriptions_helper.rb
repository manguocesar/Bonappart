module SubscriptionsHelper
  def expiration_date
    Date.today.next_year
  end

  def subscription_status(subscription)
    if subscription.invoice.present?
      link_to subscription.status.titleize, invoice_path(subscription.invoice)
    else
      subscription.status.titleize
    end
  end
end
