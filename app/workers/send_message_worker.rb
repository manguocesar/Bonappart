# frozen_string_literal: true

# sending messages in background job.
class SendMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(message_id)
    message = Message.find_by(id: message_id)
    mine = ApplicationController.render(
      partial: 'messages/mine',
      locals: { message: message }
    )

    theirs = ApplicationController.render(
      partial: 'messages/theirs',
      locals: { message: message }
    )

    ActionCable.server.broadcast "room_channel_#{message.room_id}", mine: mine, theirs: theirs, message: message
  end
end