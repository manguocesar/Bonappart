# frozen_string_literal: true

# Homes controller
class HomesController < ApplicationController
  def index
    @latest_apartments = Apartment.last(7).group_by.with_index { |_, i| i % 3 }.values
  end

  # Get Contact Us Page
  def contact_us
    @contact_us = ContactUs.new
  end

  # Get About Us Page
  def about_us; end

  # Create Contact Us Inquiry
  def create_contact_us 
    @contact_us = ContactUs.new(contact_us_params)
    if @contact_us.save
      redirect_to contact_us_path, notice: 'Thank You For Contacting Us.'
    end
  end

  def popup_forms
    return unless Constant::FORM_BASED_ON_LINKS.keys.include?(params[:name].to_sym)
    
    @title = Constant::FORM_BASED_ON_LINKS[params[:name].to_sym].first
    @partial = Constant::FORM_BASED_ON_LINKS[params[:name].to_sym].last
    if ['host', 'register'].include?(params[:name])
      @role = params[:name].eql?('host') ? 'landlord' : 'student'
    end
  end

  private

  # Permit Contact Us Parameters
  def contact_us_params
    params.require(:contact_us).permit(Constant::CONTACT_US_PARAMS)
  end
end
