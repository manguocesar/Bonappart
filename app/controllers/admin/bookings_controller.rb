# frozen_string_literal: true

module Admin
  # Bookings controller
  class BookingsController < BookingsController
    before_action :load_apartment, only: :create

    def index
      @bookings = pagination(Booking.order(created_at: :desc))
    end

    def create
      @booking = Booking.new(booking_params)
      @booking.apartment = @apartment
      if @booking.apartment.present? && @booking.save
        @apartment.update(availability: false)
        redirect_to admin_bookings_path
      else
        render :new
      end
    end

    private

    def load_apartment
      @apartment = Apartment.find_by(id: params[:apartment])
    end
  end
end
