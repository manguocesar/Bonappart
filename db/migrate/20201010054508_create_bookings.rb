class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :user
      t.timestamps
    end
  end
end
