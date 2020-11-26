# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  respond_to :html, :js

  # POST /resource
  # Override from devise for after confirmation to rooot_path
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, 'Your account is confirmed') if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to root_path }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end
end
