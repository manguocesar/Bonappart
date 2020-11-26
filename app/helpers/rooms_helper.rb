# frozen_string_literal: true

module RoomsHelper
  def display_name_as_user_role(room)
    current_user.student? ? room&.name_for_student : room&.name_for_landlord
  end
end