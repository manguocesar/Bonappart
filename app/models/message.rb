class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :content, presence: true

  scope :ascending_order, -> { order(created_at: :asc) }
  scope :descending_order, -> { order(created_at: :desc) }
end
