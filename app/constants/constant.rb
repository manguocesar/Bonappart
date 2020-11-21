# frozen_string_literal: true

module Constant
  USER_FIELDS = %i[firstname lastname username phone_no birthdate
                   gender address email password password_confirmation image].freeze

  USER_UPDATE_FIELDS = USER_FIELDS + [:current_password].freeze

  SIGN_IN_PARAMS = %i[login password password_confirmation].freeze

  RENT_RATE_DROPDOWN = ['All', 'Low to High', 'High to Low'].freeze

  CONTACT_US_PARAMS = %i[first_name last_name email subject message].freeze

  FORM_BASED_ON_LINKS = { 'login': ['Login', 'users/sessions/new'], 'register': ['Register', 'users/registrations/new'],
                          'host': ['Become A Host', 'users/registrations/new'],
                          'forgot_password': ['Forgot Your Password?', 'users/passwords/new'],
                          'resend_confirmation': ['Resend Confirmation', 'users/confirmations/new'] }.freeze

  APARTMENT_OTHER_AMENITIES = %w[shower_room total_bedrooms floor].freeze
  APARTMENT_TYPE_PARAMS = %i[name amount image].freeze
  BOOKING = 'booking'
  SUBSCRIPTION = 'subscription'
  AVAILABILITY = 'availability'
  SUBSCRIBED = 'subscribed'
  EDIT = 'edit'
  ZERO = '0.0'

  DISTANCE_FROM_UNIVERSITY = ['<10 minutes’ walk from campus', '>10 minutes’ walk from campus',
                              'Outside Fontainebleau in nearby houses', 'I do not mind'].freeze

  CAMPUS = %w[Fontainebleau Singapore].freeze
  UNIVERSITY_ADDRESS = 'Boulevard de Constance 77305 Fontainebleau'
  LESS_THAN_TEN = '<10 minutes'
  GREATER_THAN_TEN = '>10 minutes'
  OUTSIDE_FONTAINEBLEAU = 'Outside Fontainebleau'

  MONTH_ARRAY = ('1'..'12').to_a

  YEAR_ARRAY = ('2020'..'2030').to_a
end
