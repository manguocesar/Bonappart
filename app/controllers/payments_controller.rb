# frozen_string_literal: true

# Payments controller
class PaymentsController < ApplicationController

  def new
    @payment = Payment.new
    @payment.build_address
  end

  def cities
    render json: CS.cities(params[:state], :fr).to_json
  end

  def create
    StripePayment.new(params, current_user).call
    @payment = Payment.new(payment_params).tap do |payment|
                payment.stripe_token = params[:stripeToken]
                address = payment.build_address
                create_address(address)
              end
    @payment.save!
    @payment.paid!
    redirect_to apartments_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to add_payment_method_path
  end

  def create_address(address)
    address_params = params[:address]
    address.area = address_params[:area]
    address.postal_code = address_params[:postal_code]
    address.city = address_params[:city]
    address.state = CS.states(:FR)[address_params[:state].to_sym]
    address.save!
  end

  private

  def payment_params
    params.require(:payment).permit(
      :payment_type, :amount, :status, :remarks, :stripe_token, :booking_id,
      address_attributes: %i[area postal_code city country state]
    )
  end
end
