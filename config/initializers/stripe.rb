Rails.application.configure do
  config.stripe.secret_key = Rails.application.credentials.dig(Rails.env.to_sym, :stripe,:secret_key)
  config.stripe.publishable_key = Rails.application.credentials.dig(Rails.env.to_sym, :stripe,:publishable_key)
end
