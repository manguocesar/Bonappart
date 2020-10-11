# frozen_string_literal: true

# Bookings controller
class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  def index
    @bookings = pagination(Booking.all)
  end

  def show; end

  def new
    @booking = Booking.new
  end

  def edit; end

  def create
    @booking = Booking.new(booking_params)
    @booking.apartment = Apartment.find_by(id: params[:apartment])
    if @booking.save
      redirect_to add_payment_method_path, notice: t('apartment.create')
    else
      render :new
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to apartments_path, notice: t('apartment.update')
    else
      render :edit
    end
  end

  def destroy
    if @booking.destroy
      redirect_to apartments_path, notice: t('apartment.delete')
    else
      redirect_to apartments_path
    end
  end

  private

  def set_booking
    @booking = Booking.find_by(id: params[:id])
  end

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date, :user_id)
  end
end
