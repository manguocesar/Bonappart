# frozen_string_literal: true
module Admin
  # UsersController used to implement CRUD related to User.
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update destroy]

    def index
      @users = pagination(filter_users)
    end

    def filter_users
      @users = User.with_role(:landlord).order('created_at DESC')
      return @users.search_by_name_or_email(params[:search]) if params[:search].present?

      @users
    end

    def new
      @user = User.new
    end

    def edit; end

    def create
      @user = User.new(user_params)
      @user.add_role(params[:roles])
      if @user.save
        redirect_to admin_users_path, notice: t('user.create')
      else
        render :new
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: t('user.update')
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: t('user.delete')
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
