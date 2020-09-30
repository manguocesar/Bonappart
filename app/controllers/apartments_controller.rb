# frozen_string_literal: true

# Apartments controller
class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[show edit update destroy]

  def index
    @apartments = Apartment.all
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
