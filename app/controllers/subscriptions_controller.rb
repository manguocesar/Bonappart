class SubscriptionsController < ApplicationController
  before_action :load_apartment, :load_landlord, only: :new
  def new
    @subscription = Subscription.new
    respond_to do |format|
      format.js
    end
  end

  def create

  end

  private

  def load_apartment
    @apartment = Apartment.find_by_id(params[:apartment_id])
  end

  def load_landlord
    @landlord = load_apartment&.user
  end
end
