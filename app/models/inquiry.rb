class Inquiry < ApplicationRecord
  # Validations
  validates_presence_of :message, :sender_id, :receiver_id
  belongs_to :apartment
end
