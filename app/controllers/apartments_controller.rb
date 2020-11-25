# frozen_string_literal: true

# Apartments controller
class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[show edit update destroy]

  def index
    @apartments = pagination(filtered_apartments).order(created_at: :desc)
  end

  def show
    @similar_apartments = @apartment.nearbys(30)&.where&.not(id: @apartment&.id)
  end

  def new
    @apartment = Apartment.new
    authorize @apartment
    @apartment.build_rent_rate
  end

  def edit; end

  def create
    @apartment = Apartment.new(apartment_params)
    authorize @apartment
    begin
      if @apartment.save
        aparment_index_or_show_page(is_index: false, action: 'create')
      else
        render :new
      end
    rescue => exception
      puts "#{exception.inspect}"
      redirect_to apartments_path
    end
  end

  def update
    begin
      if @apartment.update(apartment_params)
        aparment_index_or_show_page(is_index: false, action: 'update')
      else
        render :edit
      end
    rescue => exception
      puts "#{exception.inspect}"
      redis_error = exception.kind_of?(Redis::CannotConnectError)
      aparment_index_or_show_page(is_index: !redis_error, action: 'update')
    end
  end

  def destroy
    begin
      if @apartment.destroy
        aparment_index_or_show_page(is_index: true, action: 'delete')
      else
        redirect_to apartments_path
      end
    rescue => exception
      puts "#{exception.inspect}"
      aparment_index_or_show_page(is_index: true, action: 'delete')
    end
  end

  private

  def aparment_index_or_show_page(is_index: true, action: 'update')
    index_or_show_path = is_index ? 's_path' : '_path'
    if current_user.admin?
      redirect_to send("admin_apartment#{index_or_show_path}".to_sym), notice: t("apartment.#{action}")
    else
      redirect_to send("landlord_apartment#{index_or_show_path}".to_sym), notice: t("apartment.#{action}")
    end
  end

  # call filter apartments service for sorting and searching
  def filtered_apartments
    FilterApartmentService.new(params, current_user).sort_apartments
  end

  # Find and set the apaatment of given ID.
  def set_apartment
    @apartment = Apartment.find_by(id: params[:id])
    authorize @apartment
  end

  # Permit the apartment parameters
  def apartment_params
    params.require(:apartment).permit(
      :title, :description, :postalcode, :floor, :campus,
      :city, :country, :area, :month, :year, :availability, :apartment_type_id,
      :arrival_date, :departure_date, :total_bedrooms,
      :shower_room, :distance_from_university, :other_facilities,
      :longitude, :latitude, :user_id, :virtual_visit_link, images: [],
      rent_rate_attributes: [
        :net_rate, :water_charge, :heating_charge, :electricity_charge, :internet_charge, :insurance_charge, :deposit_amount, included_in_net_rate: []
      ]
    )
  end
end
