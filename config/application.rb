require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApartmentBooking
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.assets.initialize_on_precompile = false
    config.action_mailer.raise_delivery_errors = true

    config.active_job.queue_adapter = :sidekiq

    config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      user_name: Rails.application.credentials.dig(:smtp_settings, :user_name),
      password: Rails.application.credentials.dig(:smtp_settings, :password),
      authentication: :plain,
      enable_starttls_auto: true
    }

    # Rails.application.routes.default_url_options[:host] = Settings.mailer.host
  end
end
