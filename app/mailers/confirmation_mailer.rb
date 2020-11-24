# frozen_string_literal: true

# confirmation email
class ConfirmationMailer < ApplicationMailer
  # Send confirmation email to student
  def student_booking_confirmed_email(student, landlord)
    @student = student
    @landlord = landlord
    mail(to: @student&.email, subject: 'Booking Confirmation')
  end

  # Send confirmation email to landlord
  def landlord_booking_confirmed_email(student, landlord)
    @student = student
    @landlord = landlord
    mail(to: @landlord&.email, subject: 'Booking Confirmation')
  end
end
