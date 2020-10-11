class InquiriesController < ApplicationController

  before_action :load_landlord, only: %i[new create]

  def new
    @inquiry = Inquiry.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    inquiry = Inquiry.new(inquiry_params)
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:sender_id, :receiver_id, :email, :message)
  end

  def load_landlord
    @landlord = Apartment.find_by_id(params[:apartment])&.user
  end
end
