# frozen_string_literal: true

# Subscriptions controller
class SubscriptionsController < ApplicationController
  before_action :load_apartment, :load_landlord, only: :new

  def index
    @subscriptions = pagination(Subscription.all)
  end

  def new
    @subscription = Subscription.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to add_payment_method_path(subscription: @subscription&.id)
    else
      render :new
    end
  end

  private

  def load_apartment
    @apartment = Apartment.find_by_id(params[:apartment_id])
  end

  def load_landlord
    @landlord = load_apartment&.user
  end

  def subscription_params
    params.require(:subscription).permit(%i[started_at expired_at user_id apartment_id])
  end
end
