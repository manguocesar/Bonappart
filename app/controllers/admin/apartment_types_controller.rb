# frozen_string_literal: true

# Apartments types controller
module Admin
  # Class begin
  class ApartmentTypesController < ApplicationController
    before_action :load_apartment_type, only: %i[edit update destroy]
    protect_from_forgery with: :null_session

    def index
      fetch_apartment_types
      # authorize @apartments
    end

    # GET
    # Initialize inquiry object
    def new
      @apartment_type = ApartmentType.new
      respond_to do |format|
        format.js
      end
    end

    # POST
    # Create apartment type
    def create
      @apartment_type = ApartmentType.new(apartment_type_params)
      if @apartment_type.save
        flash[:success] = t('admin.apartment_type.create.success')
      else
        flash[:error] = t('admin.apartment_type.create.failer')
      end
      redirect_to admin_apartment_types_path
    end

    # GET
    # Edit apartment type
    def edit
      respond_to do |format|
        format.js
      end
    end

    # PATCH
    # Update apartment type
    def update
      @apartment_type.update(apartment_type_params)
      fetch_apartment_types
      respond_to do |format|
        format.html { redirect_to admin_apartment_types_path }
        format.js
      end
    end

    # DELETE
    # Delete apartment type
    def destroy
      if @apartment_type.destroy
        redirect_to admin_apartment_types_path, notice: t('apartment.delete')
      else
        redirect_to admin_apartment_types_path
      end
    end

    private

    # Load apartment type
    def load_apartment_type
      @apartment_type = ApartmentType.find_by(id: params[:id])
      # authorize @apartment_type
    end

    def fetch_apartment_types
      @apartment_types = ApartmentType.all
    end

    # Permit the parameters
    def apartment_type_params
      params.require(:apartment_type).permit(:name, :landlord_listing_fee, :student_booking_fee, :status, :image)
    end
  end
end
