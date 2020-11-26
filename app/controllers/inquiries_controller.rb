# frozen_string_literal: true

# Inquiries controller
class InquiriesController < ApplicationController
  before_action :load_landlord, only: %i[new create]

  # GET
  # Initialize inquiry object
  def new
    @inquiry = Inquiry.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST
  # Create Inquiry
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailerWorker.perform_async(@inquiry&.id)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def render_login_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:sender_id, :receiver_id, :message, :apartment_id)
  end

  def get_user
    User.find_by(id: @inquiry.receiver_id)
  end

  def load_landlord
    @landlord = find_apartment&.user
  end

  def find_apartment
    @apartment = Apartment.find_by_id(params[:apartment])
  end
end
