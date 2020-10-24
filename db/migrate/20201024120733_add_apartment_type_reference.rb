class AddApartmentTypeReference < ActiveRecord::Migration[6.0]
  def change
    # remove_column :apartments, :apartment_type
    add_reference :apartments, :apartment_type, index: true, foreign_key: true
  end
end
