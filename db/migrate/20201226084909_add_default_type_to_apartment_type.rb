class AddDefaultTypeToApartmentType < ActiveRecord::Migration[6.0]
  def change
    add_column :apartment_types, :default_type, :boolean, default: false
  end
end
