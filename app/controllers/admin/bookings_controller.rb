# frozen_string_literal: true

module Admin
  # Bookings controller
  class BookingsController < BookingsController

    def index
      @bookings = pagination(Booking.all).per(12)
    end

    def create
      @booking = Booking.new(booking_params)
      @booking.apartment = Apartment.find_by(id: params[:apartment])
      if @booking.save
        redirect_to admin_bookings_path
      else
        render :new
      end
    end
  end
end
