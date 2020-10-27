class InquiryMailer < ApplicationMailer
  default to: 'notifications@gmail.com'
  # default from: 'notifications@gmail.com'

  # Send inquiry message and inquiry reply
  def send_inquiry(sender, receiver, inquiry)
    @sender_name = sender&.firstname
    @receiver_name = receiver&.firstname
    @message = inquiry&.message
    to = receiver&.email
    subject = t('mailer.send_inquiry.subject')
    mail(to: to, subject: subject)
  end
end
