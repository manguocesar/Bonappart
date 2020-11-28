Google::Maps.configure do |config|
  config.authentication_mode = Google::Maps::Configuration::API_KEY
  config.api_key = Rails.application.credentials.dig(Rails.env.to_sym, :google_map_api_key)
end
