# frozen_string_literal: true

class Admin::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: :show

  def index
    find_all_rooms
  end

  def show
    find_all_rooms
    render 'index'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find_by(id: params[:id])
  end

  def find_all_rooms
    @rooms = Room.all
    @room = @rooms.first if @rooms.present? && @room.blank?
  end
end
