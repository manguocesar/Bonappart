# frozen_string_literal: true

# Dashboard controller
module Landlord
  class DashboardController < ApplicationController

    # Landloard dashboards
    # Set the collections of cards
    def index
      live_ads = ['Live Ads', '', current_user.subscribed_apartment.count]
      unpaid_ads = ['Unpaid Ads', current_user.unsubscribed_apartment.count]
      bookings = ['Booked Ads', current_user.unavailable_apartments.count]
      free_ads = ['Available Ads', current_user.available_apartments.count]
      @cards = [live_ads, unpaid_ads, bookings, free_ads]
    end
  end
end
