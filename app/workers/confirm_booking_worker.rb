# frozen_string_literal: true

# Confirmation booking woker for sending email to student and landlord in background job.
class ConfirmBookingWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  # async call for sending email
  def perform(student_id, landlord_id)
    student = find_user(student_id)
    landlord = find_user(landlord_id)
    ConfirmationMailer.student_booking_confirmed_email(student, landlord).deliver_later
    ConfirmationMailer.landlord_booking_confirmed_email(student, landlord).deliver_later
  end

  private

  def find_user(user_id)
    User.find_by(id: user_id)
  end
end
