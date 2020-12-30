# frozen_string_literal: true

module Admin
  # Bookings controller
  class BookingsController < BookingsController
    before_action :load_apartment, only: :create

    def index
      @bookings = pagination(Booking.paid.order(created_at: :desc))
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

    def cancel_booking
      @booking = Booking.find_by(id: params[:booking_id])
      if @booking.present?
        @booking.update(cancelled: true, cancelled_at: Time.now)
        @booking&.apartment&.update(availability: true)
        flash[:success] = t('booking.cancelled')
      end
      redirect_to admin_bookings_path
    end

    private

    def load_apartment
      @apartment = Apartment.find_by(id: params[:apartment])
    end
  end
end
