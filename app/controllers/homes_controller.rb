# frozen_string_literal: true

# Homes controller
class HomesController < ApplicationController
  def index
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

  private

  # Permit Contact Us Parameters
  def contact_us_params
    params.require(:contact_us).permit(Constant::CONTACT_US_PARAMS)
  end
end
