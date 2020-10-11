# frozen_string_literal: true

# Payments controller
class PaymentsController < ApplicationController

  def new; end

  def create
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer: customer.id,
      shipping: {
        name: 'Dipak Rathod',
        address: {
          line1: '510 Townsend St',
          postal_code: '98140',
          city: 'San Francisco',
          state: 'CA',
          country: 'US'
        }
      },
      amount: 5000,
      description: 'email',
      currency: 'usd'
    )
    @payment = Payment.new(payment_params)
    @payment.amount = 100.0
    @payment.stripe_token = params[:stripeToken]
    @payment.save!
    @payment.update(status: 'paid')
    @payment.booking.update(status: 'paid')
    redirect_to apartments_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to add_payment_method_path
  end

  private

  def payment_params
    params.require(:payment).permit(
      :payment_type, :amount, :status, :remarks,
      :stripe_token, :booking_id
    )
  end
end
