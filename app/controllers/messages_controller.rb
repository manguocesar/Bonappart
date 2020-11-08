class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :set_message, only: [:show, :edit, :update, :destroy]


  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    # @room = Room.create(name: current_user.username)
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json

  def create
    message = current_user.messages.build(message_params)
    if message.save
      SendMessageWorker.perform_async(message.id)
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id, :room_id)
  end

  def render_message(message)
    render(partial: 'message', locals: { message: message })
  end
end
