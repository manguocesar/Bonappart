# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
	include Pundit
	before_action :authenticate_user!
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :username, :phone_no, :birthdate, :gender, :address, :email, :password, :password_confirmation, :image)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :username, :phone_no, :birthdate, :gender, :address, :email, :password, :current_password, :password_confirmation, :image)}
  end
end
