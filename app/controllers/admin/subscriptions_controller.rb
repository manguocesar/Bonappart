# frozen_string_literal: true

# Subscriptions controller
module Admin
  class SubscriptionsController < SubscriptionsController
    before_action :load_apartment, :load_user, only: :new

    def index
      @subscriptions = pagination(Subscription.all.order('created_at DESC'))
    end

    def new
      @subscription = Subscription.new
    end

    def create
      @subscription = Subscription.new(subscription_params)
      if @subscription.save
        @subscription.apartment.update(subscribed: true)
        redirect_to edit_apartment_path(@subscription.apartment)
      else
        render :new
      end
    end

    private

    def load_apartment
      @apartment = Apartment.find_by_id(params[:apartment_id])
    end

    def load_user
      @user = load_apartment&.user
    end

    def subscription_params
      params.require(:subscription).permit(%i[started_at expired_at user_id apartment_id])
    end

    def invoice_params
      params.require(:invoice).permit(%i[invoice_number date amount])
    end
  end
end
