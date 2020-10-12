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

  # Filters apartments using various filters
  def filter_result
    @apartments = if params.dig(:filter, :distance_from_university).present?
                    Apartment.filter_by_distance_from_university(params.dig(:filter, :distance_from_university))
                  elsif params.dig(:filter, :arrival_date).present?
                    Apartment.filter_by_arrival_date(params.dig(:filter, :arrival_date))
                  elsif params.dig(:filter, :departure_date).present?
                    Apartment.filter_by_departure_date(params.dig(:filter, :departure_date))
                  else
                    Apartment.all
                  end
  end

  # Returns the apartments based on search parameters
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

  # Find and set the apaatment of given ID.
  def set_apartment
    @apartment = Apartment.find_by(id: params[:id])
  end

  # Permit the apartment parameters
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
