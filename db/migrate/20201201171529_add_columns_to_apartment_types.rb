class AddColumnsToApartmentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :apartment_types, :landlord_listing_fee, :float, default: 0.0
    add_column :apartment_types, :student_booking_fee, :float, default: 0.0
    add_column :apartment_types, :campus, :integer, default: 0
  end
end
