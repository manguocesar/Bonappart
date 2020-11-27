# frozen_string_literal: true

# Dashboard controller
module Admin
  class DashboardController < ApplicationController

    # Landloard dashboards
    # Set the collections of cards
    def index
      live_ads = ['Live Ads', '', Apartment.subscribed.count]
      unpaid_ads = ['Unpaid Ads', Apartment.unsubscribed.count]
      bookings = ['Booked Ads', Apartment.unavailable.count]
      free_ads = ['Available Ads', Apartment.available.count]
      @cards = [live_ads, unpaid_ads, bookings, free_ads]
    end
  end
end
