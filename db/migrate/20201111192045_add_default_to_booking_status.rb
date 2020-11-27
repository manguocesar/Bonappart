class AddDefaultToBookingStatus < ActiveRecord::Migration[6.0]
  def up
    change_column :bookings, :status, :integer, default: 0
  end

  def down
    change_column :bookings, :status, :integer
  end
end
