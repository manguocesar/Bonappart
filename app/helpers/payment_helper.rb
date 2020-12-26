# frozen_string_literal: true

module PaymentHelper
  # Find rent of apartment using booking
  def find_rent_rate
    booking = Booking.find_by(id: params[:booking_id])
    booking&.apartment&.rent_rate
  end

  # Find net rate of apartment
  def find_net_rate
    find_rent_rate&.net_rate
  end

  # Find deposit of apartment
  def find_deposit_amount
    find_rent_rate&.deposit_amount
  end

  # Set payment URL for booking and subscription object
  def payment_url(params)
    params[:booking_id].present? ? create_payment_method_path : create_subscription_payment_path
  end

  # Find apartment title
  def apartment_title
    record = find_booking_subscription(params)
    record&.apartment.title
  end

  # Find start date of booking/subscription
  def booking_subscription_startdate
    record = find_booking_subscription(params)
    record.instance_of?(Booking) ? date_format(record.start_date) : date_format(record.started_at)
  end

  # Find end date of booking/subscription
  def booking_subscription_enddate
    record = find_booking_subscription(params)
    record.instance_of?(Booking) ? date_format(record.end_date) : date_format(record.expired_at)
  end

  # Find Booking/subscription
  def find_booking_subscription(params)
    params[:booking_id].present? ? Booking.find_by(id: params[:booking_id]) : Subscription.find_by(id: params[:subscription])
  end

  # Detail heading
  def detail_heading
    record = find_booking_subscription(params)
    record.instance_of?(Booking) ? 'Booking' : 'Subscription'
  end
end
