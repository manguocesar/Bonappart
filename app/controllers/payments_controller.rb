# frozen_string_literal: true

# Payments controller
class PaymentsController < ApplicationController

  def new
    @payment = Payment.new
    @payment.build_address
  end

  def create
    StripePayment.new(params, current_user).call
    @payment = Payment.new(payment_params).tap do |payment|
                payment.amount = 100.0
                payment.stripe_token = params[:stripeToken]
              end
    @payment.save!
    @payment.paid!
    redirect_to apartments_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to add_payment_method_path
  end

  private

  def payment_params
    params.require(:payment).permit(
      :payment_type, :amount, :status, :remarks, :stripe_token, :booking_id,
      address_attributes: %i[address postal_code city country state]
    )
  end
end
