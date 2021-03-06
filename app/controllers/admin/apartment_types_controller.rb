# frozen_string_literal: true

# Apartments types controller
module Admin
  # Class begin
  class ApartmentTypesController < ApplicationController
    before_action :load_apartment_type, only: %i[edit update destroy]
    before_action :fetch_apartment_types, only: %i[index create update]
    protect_from_forgery with: :null_session

    def index; end

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
      respond_to do |format|
        if @apartment_type.save
          flash[:success] = t('admin.apartment_type.create.success')
          format.html { redirect_to admin_apartment_types_path }
          format.js
        else
          flash[:error] = t('admin.apartment_type.create.failer')
          format.html { redirect_to admin_apartment_types_path }
          format.js
        end
      end
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
      respond_to do |format|
        format.html { redirect_to admin_apartment_types_path }
        format.js
      end
    end

    # DELETE
    # Delete apartment type
    def destroy
      if @apartment_type.destroy
        redirect_to admin_apartment_types_path, notice: t('admin.apartment_type.delete')
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
      @apartment_types = pagination(ApartmentType.all)
    end

    # Permit the parameters
    def apartment_type_params
      params.require(:apartment_type).permit(:name, :landlord_listing_fee, :student_booking_fee, :status, :campus, :image)
    end
  end
end
