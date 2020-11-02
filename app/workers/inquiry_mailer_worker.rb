# frozen_string_literal: true

# Inquiry mailer for sending inquiry email in background job.
class InquiryMailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  # async call for sending email
  def perform(sender_id, receiver_id, inquiry_id)
    sender = find_user(sender_id)
    receiver = find_user(receiver_id)
    inquiry = Inquiry.find_by(id: inquiry_id)
    InquiryMailer.send_inquiry(sender, receiver, inquiry).deliver_later
  end

  private

  # find user
  def find_user(user_id)
    User.find_by(id: user_id)
  end
end
