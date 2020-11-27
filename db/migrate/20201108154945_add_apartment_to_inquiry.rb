class AddApartmentToInquiry < ActiveRecord::Migration[6.0]
  def up
    add_reference :inquiries, :apartment, foreign_key: true
  end

  def down
    remove_reference :inquiries, :apartment, foreign_key: true
  end
end
