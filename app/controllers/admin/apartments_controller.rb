# frozen_string_literal: true

module Admin
  class ApartmentsController < ApartmentsController
    def new
      @apartment = Apartment.new
      @apartment.build_rent_rate
    end

    def create
      begin
        @apartment = Apartment.new(apartment_params)
        if @apartment.save
          aparment_index_or_show_page(is_index: false, action: 'create')
        else
          render :new
        end
      rescue => exception
        puts "#{exception.inspect}"
        aparment_index_or_show_page(is_index: true, action: 'create')
      end
    end
  end
end
