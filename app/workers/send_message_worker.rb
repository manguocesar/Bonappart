# frozen_string_literal: true

# sending messages in background job.
class SendMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(message_id, msg_from_landlord)
    message = Message.find_by(id: message_id)

    from_landlord = msg_from_landlord && msg_from_landlord == "true" ? true : false
    begin
      mine = ApplicationController.render(
        partial: 'messages/mine',
        locals: { message: message, from_landlord: from_landlord }
      )

      theirs = ApplicationController.render(
        partial: 'messages/theirs',
        locals: { message: message, from_landlord: from_landlord }
      )
    rescue => exception
      puts exception.inspect
    end

    ActionCable.server.broadcast "room_channel_#{message.room_id}", mine: mine, theirs: theirs, message: message
  end
end