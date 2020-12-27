# frozen_string_literal: true

# Apartments controller
class ApartmentsController < ApplicationController
  before_action :set_apartment, only: %i[show edit update destroy]
  before_action :update_subscribed, only: %i[index]

  def index
    @apartments = pagination(filtered_apartments)
  end

  def show
    @similar_apartments = @apartment.nearbys(30)&.where&.not(id: @apartment&.id)&.subscribed
  end

  def new
    @apartment = Apartment.new
    @apartment.build_rent_rate
  end

  def create
    begin
      @apartment = Apartment.new(apartment_params)
      if @apartment.save
        redirect_to apartment_path(@apartment), notice: t("apartment.create")
      else
        render :new
      end
    rescue => exception
      puts "#{exception.inspect}"
      apartment_index_or_show_page(is_index: true, action: 'create')
    end
  end

  def edit; end

  def update
    begin
      if @apartment.update(apartment_params.except(:user_id))
        redirect_to apartment_path(@apartment), notice: t("apartment.update")
      else
        render :edit
      end
    rescue => exception
      puts "#{exception.inspect}"
      redis_error = exception.kind_of?(Redis::CannotConnectError)
      apartment_index_or_show_page(is_index: !redis_error, action: 'update')
    end
  end

  def destroy
    begin
      if @apartment.destroy
        apartment_index_or_show_page(is_index: true, action: 'delete')
      else
        redirect_to apartments_path
      end
    rescue => exception
      puts "#{exception.inspect}"
      apartment_index_or_show_page(is_index: true, action: 'delete')
    end
  end

  private

  def update_subscribed
    Apartment.all.each do |apartment|
      apartment.update_attributes(subscribed: false) if apartment.subscription_present?
    end
  end

  def apartment_index_or_show_page(is_index: true, action: 'update')
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
      :shower_room, :distance_from_campus, :other_facilities,
      :longitude, :latitude, :user_id, :virtual_visit_link, images: [],
      rent_rate_attributes: [
        :net_rate, :water_charge, :heating_charge, :electricity_charge,
        :internet_charge, :insurance_charge, :deposit_amount,
        included_in_net_rate: []
      ]
    )
  end
end
