# frozen_string_literal: true

# Subscriptions controller
class SubscriptionsController < ApplicationController
  before_action :load_apartment, :load_landlord, only: :new

  # Subscription of Landlord
  def index
    @subscriptions = current_user.subscriptions
    @subscriptions = if params[:start_date].present? && params[:end_date].present?
                      filter_by_status(@subscriptions).created_between(params[:start_date], params[:end_date])
                    else
                      filter_by_status(@subscriptions)
                    end
    @subscriptions = pagination(@subscriptions)
  end

  # Filter subscriptions by status
  def filter_by_status(subscriptions)
    return subscriptions if params[:status].blank?

    subscriptions.filter_by_status(params[:status])
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @invoice = @subscription.build_invoice(invoice_params)
    if @subscription.save
      @invoice.save
      redirect_to invoice_details_path(invoice: @invoice&.id)
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

  def invoice_params
    params.require(:invoice).permit(%i[invoice_number date amount])
  end
end
