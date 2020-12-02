class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    find_rooms
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    find_rooms
    render 'index'
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name_for_landlord, :name_for_student, :inquiry_id)
  end

  def find_rooms
    column_name = current_user.student? ? 'sender_id' : 'receiver_id'
    @inquiries = Inquiry.where("#{column_name}=#{current_user&.id}")
    @rooms = @inquiries.map(&:rooms).flatten.compact
    @room = @rooms.first if @rooms.present? && @room.blank?
  end
end
