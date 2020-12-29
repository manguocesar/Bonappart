# frozen_string_literal: true

module InquiryHelper
  def render_url
    inquiry = Inquiry.find_by(apartment_id: params[:id])
    url =
      if inquiry.present?
        past_inquiry = inquiry&.sender_id.eql?(current_user&.id)
        if past_inquiry
          room = Room.find_by(inquiry: inquiry)
          room.present? ? room_path(room) : inquire_creation_url
        else
          inquire_creation_url
        end
      else
        inquire_creation_url
      end
    { url: url, is_remote: url.include?('inquiries') }
  end

  def inquire_creation_url
    new_inquiry_path(apartment: params[:id])
  end
end
