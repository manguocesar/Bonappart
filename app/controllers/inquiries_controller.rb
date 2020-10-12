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
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_inquiry(current_user, get_user, @inquiry).deliver_now
      respond_to do |format|
        format.html
        format.js
      end
    else
      respond_to do |format|
        format.html
        format.js
      end
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
