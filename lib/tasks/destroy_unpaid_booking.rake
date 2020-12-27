namespace :destroy_unpaid_booking do
  desc 'Destroy unpaid booking'
  task unpaid_booking: :environment do
    pending_bookings = Booking.pending
    pending_apartments = pending_bookings.map(&:apartment).compact.flatten
    pending_apartments.each do |aprt|
      aprt.update_column(:booking_id, nil)
    end
    pending_bookings.destroy_all
  end
end
