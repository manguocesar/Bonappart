class AddSubscriptionToPayment < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :subscription, index: true, foreign_key: true
  end
end
