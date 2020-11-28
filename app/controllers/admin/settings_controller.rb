# frozen_string_literal: true
module Admin
  # SettingssController used to manage default email settings of application.
  class SettingsController < ApplicationController
    before_action :set_settings, only: %i[show edit update]

    def index
      @settings = Setting.all
    end

    def new
      @setting = Setting.new
    end

    def edit; end

    def create
      @setting = Setting.new(setting_params)
      if @setting.save
        redirect_to admin_settings_path, notice: t('setting.create')
      else
        render :new
      end
    end

    def update
      if @setting.update(setting_params)
        redirect_to admin_settings_path, notice: t('setting.update')
      else
        render :edit
      end
    end

    def destroy
      @setting.destroy
      redirect_to admin_settings_path, notice: t('setting.delete')
    end

    private

    def set_settings
      @setting = Setting.find_by(id: params[:id])
    end

    def setting_params
      params.require(:setting).permit(:address, :port, :domain, :user_name, :password)
    end
  end
end
