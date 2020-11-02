class AddApartmentTypeRefToApartments < ActiveRecord::Migration[6.0]
  def change
    add_reference :apartments, :apartment_type, foreign_key: true
  end
end
