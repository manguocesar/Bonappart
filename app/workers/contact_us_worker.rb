# frozen_string_literal: true

# ContactUs mailer for sending email to website admin in background job.
class ContactUsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  # async call for sending email
  def perform(contact_obj)
    contact_request = ContactUs.find_by(id: contact_obj)
    ContactUsMailer.send_inquiry(contact_request).deliver_later
  end
end
