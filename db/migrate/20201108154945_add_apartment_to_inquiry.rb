class AddApartmentToInquiry < ActiveRecord::Migration[6.0]
  def change
    add_reference :inquiries, :apartment, null: false, foreign_key: true
  end
end
