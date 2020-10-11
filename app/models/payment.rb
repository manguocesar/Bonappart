# frozen_string_literal: true

# Payment model
class Payment < ApplicationRecord
  belongs_to :booking
  enum status: { pending: 0, failed: 1, paid: 2}
end
