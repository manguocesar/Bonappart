class ContactUsMailer < ApplicationMailer
  # Send contact us inquiry mail
  def send_inquiry(contact_us_id)
    return if contact_us_id.blank?

    contact_us_request = ContactUs.find_by(id: contact_us_id)
    from_email = 'bonapartcontact@gmail.com'
    to_email = contact_us_request&.email
    @sender_name = [contact_us_request&.first_name, contact_us_request&.last_name].join(' ')
    @message = contact_us_request&.message
    # Change Admin Email Here
    mail(to: from_email, from: to_email, subject: contact_us_request&.subject) if contact_us_request&.email.present?
  end
end
