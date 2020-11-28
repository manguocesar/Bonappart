class AddStatusToApartmentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :apartment_types, :status, :integer, default: 0
  end
end
