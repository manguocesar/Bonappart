class PaymentsController < ApplicationController
  
  def new
    # binding.pry
    # respond_to do |format|
    #   format.js
    # end
	end

  def create
    binding.pry

    # @amount = 100
    # @booking = Booking.new(booking_params)
    # @booking.apartment = Apartment.find_by(id: params[:booking][:apartment_id])
    # @booking.status = 'pending'
    # @booking.save!

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
    binding.pry
    @payment = Payment.new(payment_params)
    @payment.save!
    redirect_to apartments_path
	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to apartments_path
  end
  
  private

  def set_payment
    @booking = Booking.find_by(id: params[:id])
  end

  def payment_params
    params.require(:payment).permit(
      :type, :amount, :status, :remarks,
      :stripe_token, :booking_id
    )
  end

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date, :user_id)
  end
end
