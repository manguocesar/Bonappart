class AddCampusToApartments < ActiveRecord::Migration[6.0]
  def change
    add_column :apartments, :campus, :string
  end
end
