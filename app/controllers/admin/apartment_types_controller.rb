# frozen_string_literal: true

# Apartments types controller
module Admin
  # Class begin
  class ApartmentTypesController < ApplicationController
    before_action :load_apartment_type, only: %i[edit update destroy]

    def index
      @apartment_types = ApartmentType.all
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
      @apartment_type.save
      respond_to do |format|
        format.html
        format.js
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
        format.html
        format.js
      end
    end

    # DELETE
    # Delete apartment type
    def destroy
      if @apartment_type.destroy
        redirect_to apartment_types_path, notice: t('apartment.delete')
      else
        redirect_to apartment_types_path
      end
    end

    private

    # Load apartment type
    def load_apartment_type
      @apartment_type = Apartment.find_by(id: params[:id])
      # authorize @apartment_type
    end

    # Permit the parameters
    def apartment_type_params
      params.require(:apartment_type).permit(:name, :amount)
    end
  end
end
