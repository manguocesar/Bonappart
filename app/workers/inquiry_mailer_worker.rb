# frozen_string_literal: true

# Inquiry mailer for sending inquiry email in background job.
class InquiryMailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  # async call for sending email
  def perform(inquiry_id)
    inquiry = Inquiry.find_by(id: inquiry_id)
    sender = find_user(inquiry.sender_id)
    receiver = find_user(inquiry.receiver_id)
    apartment = find_apartment(inquiry.apartment_id)
    room = Room.create(name_for_student: "#{apartment&.title} - #{receiver.username}" , name_for_landlord: "#{apartment&.title} - #{sender.username}", inquiry: inquiry)
    message = Message.create(content: inquiry&.message, user_id: inquiry&.sender_id, room: room)
    InquiryMailer.send_inquiry(sender, receiver, inquiry).deliver_later
  end

  private

  # find user
  def find_user(user_id)
    User.find_by(id: user_id)
  end

  # find user
  def find_apartment(id)
    Apartment.find_by(id: id)
  end
end
