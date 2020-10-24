module SubscriptionsHelper
  def expiration_date
    Date.today.next_year
  end
end
