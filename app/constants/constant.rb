# frozen_string_literal: true

module Constant
  USER_FIELDS = %i[firstname lastname username phone_no birthdate
                   gender address email password password_confirmation image].freeze
  USER_UPDATE_FIELDS = USER_FIELDS + [:current_password].freeze
end
