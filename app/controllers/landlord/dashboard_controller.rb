# frozen_string_literal: true

# Dashboard controller
module Landlord
  class DashboardController < ApplicationController

    # Landloard dashboards
    # Set the collections of cards
    def index
      @bookings = pagination(bookings).per(2)
      @invoices = pagination(current_user.invoices.order('created_at DESC')).per(2)
      @apartments = pagination(current_user.apartments.order('created_at DESC')).per(2)
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
