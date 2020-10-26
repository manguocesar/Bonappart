# frozen_string_literal: true

module Constant
  USER_FIELDS = %i[firstname lastname username phone_no birthdate
                   gender address email password password_confirmation image].freeze
  
  USER_UPDATE_FIELDS = USER_FIELDS + [:current_password].freeze

  RENT_RATE_DROPDOWN = ['All', 'Low to High', 'High to Low'].freeze

  CONTACT_US_PARAMS = %i[first_name last_name email subject message].freeze
end
