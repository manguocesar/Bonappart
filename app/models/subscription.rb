# frozen_string_literal: true

# Subscription model
class Subscription < ApplicationRecord
  # Enums
  enum status: { pending: 0, failed: 1, paid: 2 }

  # Associations
  has_many :payments
  belongs_to :user
  belongs_to :apartment
end
