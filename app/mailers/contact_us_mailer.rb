class ContactUsMailer < ApplicationMailer

  # Send contact us inquiry mail
  def send_inquiry(contact_us_request)
    @sender_name = [contact_us_request.first_name, contact_us_request.last_name].join(' ')
    @message = contact_us_request.message
    mail(to: 'jigarshah2097@gmail.com', subject: contact_us_request.subject)
  end
end
