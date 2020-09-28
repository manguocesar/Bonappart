class CreateApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :apartments do |t|
      t.string :title
      t.string :description
      t.string :postalcode
      t.string :floor
      t.string :city
      t.string :country
      t.string :area
      t.string :type
      t.boolean :availability
      t.datetime :available_date
      t.string :status
      t.integer :total_bedrooms
      t.string :shower_room
      t.string :distance_from_university
      t.string :other_facilities
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
