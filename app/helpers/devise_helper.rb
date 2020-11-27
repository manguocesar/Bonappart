# frozen_string_literal: true

module DeviseHelper
  def devise_error_messages!
    if resource.errors.full_messages.any?
      flash.now[:error] = resource.errors.full_messages
    end
    ''
  end

  def edit_profile_url
    if current_user.landlord?
      edit_landlord_user_path(current_user&.id)
    elsif current_user.admin?
      edit_admin_user_path(current_user&.id)
    else
      edit_user_registration_path
    end
  end
end
