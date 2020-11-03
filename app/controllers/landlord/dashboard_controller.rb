# frozen_string_literal: true

# Dashboard controller
module Landlord
  class DashboardController < ApplicationController
    def index
      live_ads = ['Live Ads', Apartment.all.select(&:subscribed).count]
      unpaid_ads = ['Unpaid Ads', Apartment.all.reject(&:subscribed).count]
      bookings = ['Booked Ads', current_user.apartments.reject(&:availability).count]
      free_ads = ['Available Ads', 6]
      @cards = [live_ads, unpaid_ads, bookings, free_ads]
    end
  end
end