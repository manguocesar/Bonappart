class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.integer :invoice_number
      t.datetime :date
      t.float :amount
      t.integer :status, default: 0
      t.references :booking, foreign_key: true
      t.references :subscription, foreign_key: true

      t.timestamps
    end
  end
end
