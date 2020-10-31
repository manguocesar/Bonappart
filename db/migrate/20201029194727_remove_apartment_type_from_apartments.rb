class RemoveApartmentTypeFromApartments < ActiveRecord::Migration[6.0]
  def up
    remove_column :apartments, :apartment_type
  end

  def down
    add_column :apartments, :apartment_type, :string
  end
end
