class MessagesController < ApplicationController
  before_action :logged_in_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      SendMessageWorker.perform_async(message.id, params.dig('message', 'msg_from_landlord'))
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

  def message_params
    params.require(:message).permit(:content, :user_id, :room_id)
  end
end
