# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      'login'
    else
      'application'
    end
  end

  protected

  # Add customized/new signup params for permit
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(Constant::USER_FIELDS) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(Constant::USER_UPDATE_FIELDS) }
  end

  # For setting paginations in apartments page
  def pagination(data)
    updated_data = data.is_a?(Array) ? Kaminari.paginate_array(data) : data
    updated_data.page(params[:page]).per(10)
  end
end
