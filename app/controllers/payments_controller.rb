# frozen_string_literal: true

# Payments controller
class PaymentsController < ApplicationController

  def new
    @payment = Payment.new
    @payment.build_address
  end

  def cities
    fetch_cities = CS.cities(params[:state], :fr)
    cities = fetch_cities.reject{|c| c == '1' }
    render json: cities.to_json
  end

  def create
    StripePayment.new(params, current_user).call
    @payment = Payment.new(payment_params).tap do |payment|
                 payment.stripe_token = params[:stripeToken]
                 address = payment.build_address
                 create_address(address)
               end
    @payment.save
    @payment.paid!
    redirect_to invoice_path(invoice)
    ConfirmBookingWorker.perform_async(current_user&.id, find_landlord_user&.id)
    rescue => exception
      flash[:error] = exception.message
      redirect_to add_payment_method_path(amount: payment_params['amount'], booking_id: payment_params['booking_id'])
  end

  def create_subscription_payment
    StripePayment.new(params, current_user).call
    payment = Payment.new(payment_params)
    create_address(payment.build_address)
    @payment = payment.tap do |pay|
                 pay.stripe_token = params[:stripeToken]
               end
    @payment.save
    @payment.paid!
    redirect_to invoice_path(invoice)
    rescue => exception
      flash[:error] = exception.message
      redirect_to create_subscription_payment_path
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
      :payment_type, :amount, :status, :remarks, :stripe_token, :subscription_id, :booking_id,
      address_attributes: %i[area postal_code city country state]
    )
  end

  def invoice
    @payment&.booking&.invoice || @payment&.subscription&.invoice
  end

  def find_landlord_user
    booking = Booking.find_by(id: payment_params[:booking_id])
    booking&.apartment&.user
  end
end
