# frozen_string_literal: true

# Subscriptions controller
module Landlord
  class SubscriptionsController < SubscriptionsController
    before_action :load_apartment, :load_landlord, only: :new

    def index
      @subscriptions = pagination(Subscription.all.order("created_at DESC"))
    end

    def new
      @subscription = @apartment.subscriptions.new
    end

    def create
      @subscription = Subscription.new(subscription_params)
      @invoice = @subscription.build_invoice(invoice_params)
      if @subscription.save
        @invoice.save
        if @subscription.apartment.campus == 'Singapore'
          @subscription.apartment.update(subscribed: true)
          redirect_to invoice_path(@invoice)
        else
          redirect_to invoice_details_path(invoice: @invoice&.id)
        end
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
end
