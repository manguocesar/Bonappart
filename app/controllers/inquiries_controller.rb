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
      InquiryMailer.send_inquiry(current_user, get_user, @inquiry).deliver_now
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
    params.require(:inquiry).permit(:sender_id, :receiver_id, :message)
  end

  def get_user
    User.find_by(id: @inquiry.receiver_id)
  end

  def load_landlord
    @landlord = Apartment.find_by_id(params[:apartment])&.user
  end
end
