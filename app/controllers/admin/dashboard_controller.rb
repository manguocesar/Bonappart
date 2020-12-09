# frozen_string_literal: true

# Dashboard controller
module Admin
  class DashboardController < ApplicationController

    # Landloard dashboards
    # Set the collections of cards
    def index
      total_ads = ['All Ads', '', Apartment.count]
      live_ads = ['Live Ads', '', Apartment.subscribed.count]
      @cards = [live_ads, total_ads]
    end
  end
end
