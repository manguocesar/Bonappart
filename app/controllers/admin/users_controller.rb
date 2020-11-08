# frozen_string_literal: true
module Admin
  # UsersController used to implement CRUD related to User.
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update destroy]

    def index
      @users = pagination(User.with_role(:student).order('created_at DESC'))
    end

    def new
      @user = User.new
    end

    def edit; end

    def create
      @user = User.new(user_params)
      @user.add_role(params[:roles])
      if @user.save
        redirect_to admin_users_path, notice: 'User Added Successfully'
      else
        render :new
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User Update Succsessfully'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'User Deleted Succsessfully'
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
