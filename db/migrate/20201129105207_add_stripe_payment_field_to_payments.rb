class AddStripePaymentFieldToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :stripe_transaction_id, :string
    add_column :payments, :stripe_payment_id, :string
  end
end
