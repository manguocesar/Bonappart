class AddCancelledColumnsToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :cancelled, :boolean, default: false
    add_column :bookings, :cancelled_at, :datetime
  end
end
