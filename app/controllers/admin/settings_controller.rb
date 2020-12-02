# frozen_string_literal: true
module Admin
  # SettingssController used to manage default email settings of application.
  class SettingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_settings, only: %i[edit update]
    before_action :redirect_if_unauthorized, if: :is_not_admin?

    def index
      @setting = Setting.last
    end

    def edit; end

    def update
      if @setting.update(setting_params)
        redirect_to admin_settings_path, notice: t('setting.update')
      else
        render :edit
      end
    end

    private

    def set_settings
      @setting = Setting.find_by(id: params[:id])
    end

    def setting_params
      params.require(:setting).permit(:address, :port, :domain, :user_name, :password)
    end

    def is_not_admin?
      !current_user.admin?
    end

    def redirect_if_unauthorized
      if current_user.landlord?
        redirect_to landlord_dashboard_path
      else
        redirect_to_root_path
      end
    end
  end
end
