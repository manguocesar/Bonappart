# frozen_string_literal: true

module Landlord
  # Bookings controller
  class BookingsController < BookingsController

    def index
      @bookings = pagination(bookings)
    end

    private

    def bookings
      if current_user.present? && current_user.apartments.present?
        current_user.apartments.joins(:booking).map(&:booking)
      else
        []
      end
    end
  end
end
