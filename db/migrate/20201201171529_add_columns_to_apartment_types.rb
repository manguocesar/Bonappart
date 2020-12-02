class AddColumnsToApartmentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :apartment_types, :landlord_listing_fee, :float, default: 0.0
    add_column :apartment_types, :student_booking_fee, :float, default: 0.0
    add_column :apartment_types, :campus, :integer, default: 0

    listing_fee = { 'Singapore' => 0, 'Fontainebleau' => 100 }
    ApartmentType.campus.each do |type|
      apartment_type = ApartmentType.new
      apartment_type.name = 'default'
      apartment_type.student_booking_fee = 50
      apartment_type.landlord_listing_fee = listing_fee[type.first]
      apartment_type.campus = type.first
      apartment_type.save(validate: false)
    end
  end
end
