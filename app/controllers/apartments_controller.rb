# frozen_string_literal: true

# Apartments controller
class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[show edit update destroy]

  def index
    if params.dig(:filter).present?
      @apartments = pagination(filter_result)
    else
      @apartments = pagination(search_data)
    end
  end

  def filter_result
    if params.dig(:filter, :distance_from_university).present?
      @apartments = Apartment.filter_by_distance_from_university(params.dig(:filter, :distance_from_university))
    elsif params.dig(:filter, :arrival_date).present?
      @apartments = Apartment.filter_by_arrival_date(params.dig(:filter, :arrival_date))
    elsif params.dig(:filter, :departure_date).present?
      @apartments = Apartment.filter_by_departure_date(params.dig(:filter, :departure_date))
    else
      @apartments = Apartment.all
    end
  end

  def search_data
    search_data = params.dig(:search)
    return Apartment.all if search_data.blank?

    Apartment.filter_by_type(params.dig(:search))
  end

  def show; end

  def new
    @apartment = Apartment.new
  end

  def edit; end

  def create
    @apartment = Apartment.new(apartment_params)
    if @apartment.save
      redirect_to apartments_path, notice: t('apartment.create')
    else
      render :new
    end
  end

  def update
    if @apartment.update(apartment_params)
      redirect_to apartments_path, notice: t('apartment.update')
    else
      render :edit
    end
  end

  def destroy
    if @apartment.destroy
      redirect_to apartments_path, notice: t('apartment.delete')
    else
      redirect_to apartments_path
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find_by(id: params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(
      :title, :description, :postalcode, :floor,
      :city, :country, :area, :apartment_type, :availability,
      :arrival_date, :departure_date, :total_bedrooms,
      :shower_room, :distance_from_university, :other_facilities,
      :longitude, :latitude, :user_id, images: []
    )
  end
end
