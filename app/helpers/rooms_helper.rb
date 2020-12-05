# frozen_string_literal: true

module RoomsHelper
  def display_name_as_user_role(room)
    if current_user.student?
      room&.name_for_student
    elsif current_user.landlord?
      room&.name_for_landlord
    elsif current_user.admin?
      name_for_admin_user(room)
    end
  end

  def pluck_conversations_dates(room)
    room.messages.ascending_order.map { |m| [m.created_at.to_date, m.id] }.uniq(&:first)
  end

  def proper_class_name(message)
    date_number = message.first.to_formatted_s(:number)
    "#{date_number}_#{message.last}"
  end

  private

  def name_for_admin_user(room)
    student_name_array = room.name_for_student.split('-')
    landlord_name_array = room.name_for_landlord.split('-')
    "#{student_name_array.first}(#{student_name_array.last.strip}-#{landlord_name_array.last.strip})"
  end
end
