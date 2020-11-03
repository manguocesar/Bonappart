# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, Pundit::NotDefinedError, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  private

  def layout_by_resource
    if request.url.include?('landlord' || 'admin') && current_user.administrative_role?
      'dashboard'
    else
      'application'
    end
  end

  protected

  # Add customized/new signup params for permit
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(Constant::SIGN_IN_PARAMS) }
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(Constant::USER_FIELDS) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(Constant::USER_UPDATE_FIELDS) }
  end

  # For setting paginations in apartments page
  def pagination(data)
    updated_data = data.is_a?(Array) ? Kaminari.paginate_array(data) : data
    updated_data.page(params[:page]).per(9)
  end

  def user_not_authorized(exception)
    flash[:alert] = t('cannot_perform')
    redirect_to(request.referrer || root_path)
  end

  def record_not_found(exception)
    respond_to do |format|
      format.html { redirect_to(request.referrer || root_path, alert: t('cannot_perform')) }
      format.json { render json: { success: false, error: exception.message } }
    end
  end
end
