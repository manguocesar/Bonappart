# frozen_string_literal: true

# Setting model
class Setting < ApplicationRecord
  # validates presence of fields
  validates_presence_of :address, :port, :domain, :user_name, :password
end
