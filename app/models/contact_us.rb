# frozen_string_literal: true

# Contact model for contact website admin
class ContactUs < ApplicationRecord
  enum status: { unread: 0, read: 1 }

  validates :first_name, :last_name, :subject, :message, :email, presence: true

  after_create :send_email

  # Send contact us email to website admin
  def send_email
    ContactUsMailer.send_inquiry(self&.id).deliver_later
  end
end
