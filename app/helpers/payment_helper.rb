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
end
