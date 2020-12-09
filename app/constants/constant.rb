# frozen_string_literal: true

module Constant
  USER_FIELDS = %i[firstname lastname username phone_no birthdate
                   gender address email password password_confirmation image terms_of_service].freeze

  USER_UPDATE_FIELDS = USER_FIELDS + [:current_password].freeze

  SIGN_IN_PARAMS = %i[login password password_confirmation].freeze

  RENT_RATE_DROPDOWN = ['All', 'Low to High', 'High to Low'].freeze

  CONTACT_US_PARAMS = %i[first_name last_name email subject message].freeze

  FORM_BASED_ON_LINKS = { 'login': ['Login', 'users/sessions/new'], 'student': ['Register', 'users/registrations/new'],
                          'host': ['Become A Host', 'users/registrations/new'],
                          'forgot_password': ['Forgot Your Password?', 'users/passwords/new'],
                          'resend_confirmation': ['Resend Confirmation', 'users/confirmations/new'] }.freeze

  APARTMENT_OTHER_AMENITIES = %w[shower_room total_bedrooms].freeze
  APARTMENT_TYPE_PARAMS = %i[name amount image].freeze
  BOOKING = 'booking'
  SUBSCRIPTION = 'subscription'
  AVAILABILITY = 'availability'
  SUBSCRIBED = 'subscribed'
  EDIT = 'edit'
  ZERO = '0.0'

  DEFAULT_APARTMENT_TYPE = 'default'

  MONTH_ARRAY = ('1'..'12').to_a
  YEAR_ARRAY = ('2020'..'2030').to_a

  DISTANCE_FROM_CAMPUS = [
    '<10 minutes’ walk from campus',
    '>10 minutes’ walk from campus',
    'Outside Fontainebleau in nearby houses',
    'Not important'
  ].freeze

  CAMPUS = %w[Fontainebleau Singapore].freeze
  FONTAINEBLEAU_CAMPUS_ADDRESS = 'Boulevard de Constance 77305 Fontainebleau France'
  LESS_THAN_TEN = '<10 minutes'
  GREATER_THAN_TEN = '>10 minutes'
  OUTSIDE_FONTAINEBLEAU = 'Outside Fontainebleau'

  COORDINATES_OF_FONTAINEBLEAU_CAMPUS = [48.4022714, 2.6872183]
  COORDINATES_OF_SINGAPORE_CAMPUS = [1.3000124, 103.7865809]

  PAYMENT_AMOUNT = 100
  BALANCE_DUE = 0
end
