# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, Pundit::NotDefinedError, with: :record_not_found

  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  helper_method :root_url_as_per_role

  private

  def root_url_as_per_role
    if current_user && current_user.landlord?
      landlord_dashboard_path
    elsif current_user && current_user.admin?
      admin_dashboard_path
    end
  end

  def layout_by_resource
    if administrative_request? && current_user.administrative_role?
      'dashboard'
    else
      'application'
    end
  end

  def administrative_request?
    (request.url.include?('landlord') || request.url.include?('admin'))
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
