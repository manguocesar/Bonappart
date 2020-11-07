# frozen_string_literal: true

module Landlord
  class ApartmentsController < ApartmentsController
    def new
      @apartment = Apartment.new
      @apartment.build_rent_rate
    end

    def create
      @apartment = Apartment.new(apartment_params)
      if @apartment.save
        redirect_to landlord_apartments_path, notice: t('apartment.create')
      else
        render :new
      end
    end
  end
end
