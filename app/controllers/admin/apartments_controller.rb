# frozen_string_literal: true

module Admin
  class ApartmentsController < ApartmentsController
    def new
      @apartment = Apartment.new
      @apartment.build_rent_rate
    end

    def create
      @apartment = Apartment.new(apartment_params)
      if @apartment.save
        redirect_to admin_apartments_path, notice: t('apartment.create')
      else
        render :new
      end
    end
  end
end
