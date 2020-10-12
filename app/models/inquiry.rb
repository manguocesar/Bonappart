class Inquiry < ApplicationRecord
  validates_presence_of :message, :sender_id, :receiver_id
end
