class AddBookingToApartments < ActiveRecord::Migration[6.0]
  def change
    add_reference :apartments, :booking, foreign_key: true
  end
end
