# frozen_string_literal: true

# Bookings controller
class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[create edit update]

  def index
    @bookings = pagination(Booking.all)
  end

  def show; end

  def new
    @booking = Booking.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit; end

  def create
    @booking = Booking.new(booking_params)
    @booking.apartment = Apartment.find_by(id: params[:apartment])
    if @booking.save
      redirect_to add_payment_method_path(booking_id: @booking&.id)
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

  # Bookings of student
  def student_bookings
    @bookings = current_user.bookings
    @bookings = if params[:start_date].present? && params[:end_date].present?
                  filter_by_status(@bookings).created_between(params[:start_date], params[:end_date])
                else
                  filter_by_status(@bookings)
                end
    @bookings = pagination(@bookings)                
  end

  # Filter student bookings by status
  def filter_by_status(bookings)
    return bookings if params[:status].blank?
    
    bookings.filter_by_status(params[:status])
  end

  private

  def set_booking
    @booking = Booking.find_by(id: params[:id])
  end

  def booking_params
    params.require(:booking).permit(%i[status start_date end_date user_id apartment])
  end
end
