class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :payment_type
      t.float :amount
      t.integer :status
      t.text :remarks
      t.string :stripe_token
      t.belongs_to :booking
      t.timestamps
    end
  end
end
