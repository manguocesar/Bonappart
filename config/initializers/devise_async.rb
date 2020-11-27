# Supported options: :resque, :sidekiq, :delayed_job
Devise::Async.setup do |config|
  config.enabled = true
end
