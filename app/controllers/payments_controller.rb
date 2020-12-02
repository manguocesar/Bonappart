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
    ActiveRecord::Base.transaction do
      @stripe_payment_record = StripePayment.new(params, current_user).call
      if @stripe_payment_record.kind_of?(Stripe::Charge)
        @payment = Payment.new(payment_params).tap do |payment|
                    payment.stripe_token = params[:stripeToken]
                    payment.stripe_payment_id = @stripe_payment_record.id
                    payment.stripe_transaction_id = @stripe_payment_record.balance_transaction
                    address = payment.build_address
                    create_address(address)
                  end
        @payment.save
        @payment.paid!
      end
    end
    if @payment&.id.present?
      redirect_to invoice_path(invoice)
      ConfirmationMailer.student_booking_confirmed_email(current_user&.id, find_landlord_user&.id).deliver_later
      ConfirmationMailer.landlord_booking_confirmed_email(current_user&.id, find_landlord_user&.id).deliver_later
    else
      flash[:error] = @stripe_payment_record if @stripe_payment_record && @stripe_payment_record.kind_of?(String)
      redirect_to add_payment_method_path(amount: payment_params['amount'], booking_id: payment_params['booking_id'])
    end
    rescue => exception
      flash[:error] = @stripe_payment_record && @stripe_payment_record.kind_of?(String) ? @stripe_payment_record : exception&.message
      redirect_to add_payment_method_path(amount: payment_params['amount'], booking_id: payment_params['booking_id'])
  end

  def create_subscription_payment
    ActiveRecord::Base.transaction do
      @stripe_payment_record = StripePayment.new(params, current_user).call
      if @stripe_payment_record.kind_of?(Stripe::Charge)
        @payment = Payment.new(payment_params).tap do |payment|
                      payment.stripe_token = params[:stripeToken]
                      payment.stripe_payment_id = @stripe_payment_record.id
                      payment.stripe_transaction_id = @stripe_payment_record.balance_transaction
                      address = payment.build_address
                      create_address(address)
                    end
        @payment.save
        @payment.paid!
      end
    end
    if @payment&.id.present?
      redirect_to invoice_path(invoice)
    else
      flash[:error] = @stripe_payment_record if @stripe_payment_record && @stripe_payment_record.kind_of?(String)
      redirect_to_apartment
    end
    rescue => exception
      flash[:error] = @stripe_payment_record && @stripe_payment_record.kind_of?(String) ? @stripe_payment_record : exception&.message
      redirect_to_apartment
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

  def redirect_to_apartment
    if current_user.landlord?
      redirect_to landlord_apartments_path
    else
      redirect_to admin_apartments_path
    end
  end
end
