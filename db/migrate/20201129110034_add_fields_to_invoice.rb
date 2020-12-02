class AddFieldsToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :description, :string
    add_column :invoices, :vat_rate, :float
    add_reference :invoices, :user, foreign_key: true
    add_reference :invoices, :apartment, foreign_key: true
  end
end
