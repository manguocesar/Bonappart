class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.integer :invoice_number
      t.datetime :date
      t.float :amount
      t.boolean :status, default: :unpaid
      t.references :payment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
