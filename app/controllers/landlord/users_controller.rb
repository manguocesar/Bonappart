# frozen_string_literal: true
module Landlord
  # UsersController used to implement CRUD related to User.
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update]

    def edit; end

    def update
      if update_user
        bypass_sign_in(@user)
        redirect_to root_path, notice: t('user.profile_update')
      else
        render :edit
      end
    end

    def update_user
      if user_params[:password].blank?
        @user.update_without_password(user_params) 
      else
        @user.update(user_params)
      end
    end

    private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email, :firstname, :lastname, :username, :phone_no,
        :birthdate, :gender, :address, :password, :password_confirmation
      )
    end
  end
end
