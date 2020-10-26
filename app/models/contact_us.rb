class ContactUs < ApplicationRecord
  enum status: { unread: 0, read: 1 }

  validates :first_name, :last_name, :subject, :message, :email, presence: true
  
  after_create :send_email

  def send_email
    ContactUsMailer.send_inquiry(self).deliver_later
  end
end
