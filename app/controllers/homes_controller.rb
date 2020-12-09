# frozen_string_literal: true

# Homes controller
class HomesController < ApplicationController
  rescue_from Redis::CannotConnectError, with: :redirect_to_root_path

  def index
    if root_url_as_per_role.present?
      redirect_to root_url_as_per_role
    else
      @latest_apartments = Apartment.last(7).group_by.with_index { |_, i| i % 3 }.values
    end
  end

  # Get Contact Us Page
  def contact_us
    @contact_us = ContactUs.new
  end

  # Get About Us Page
  def about_us; end

  # Get FAQ page
  def faq; end

  # GET
  # Terms & Condition
  def terms_and_conditions; end

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
    if %w[host student].include?(params[:name])
      @role = params[:name].eql?('host') ? 'landlord' : 'student'
    end
  end

  private

  # Permit Contact Us Parameters
  def contact_us_params
    params.require(:contact_us).permit(Constant::CONTACT_US_PARAMS)
  end
end
