# frozen_string_literal: true

module Admin
  # Bookings controller
  class BookingsController < BookingsController

    def index
      @bookings = pagination(Booking.all).per(12)
    end
  end
end
