# frozen_string_literal: true

# confirmation email
class ConfirmationMailer < ApplicationMailer
  # Send confirmation email to student
  def student_booking_confirmed_email(student_id, landlord_id, apartment)
    @student = find_user(student_id)
    @landlord = find_user(landlord_id)
    @apartment = apartment
    mail(to: @student&.email, subject: 'Booking Confirmation')
  end

  # Send confirmation email to landlord
  def landlord_booking_confirmed_email(student_id, landlord_id, apartment)
    @student = find_user(student_id)
    @landlord = find_user(landlord_id)
    @apartment = apartment
    mail(to: @landlord&.email, subject: 'Booking Confirmation')
  end

  private

  def find_user(user_id)
    User.find_by(id: user_id)
  end
end
