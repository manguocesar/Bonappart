class CustomizeMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  default template_path: 'users/mailer' # to make sure that your mailer uses the devise views
  # If there is an object in your application that returns a contact email, you can use it as follows
  # Note that Devise passes a Devise::Mailer object to your proc, hence the parameter throwaway (*).
  default from: 'from@example.com'
  before_action :set_smtp_settings

  def set_smtp_settings
    setting = Setting&.last
    ActionMailer::Base.smtp_settings = {
      address: setting.address,
      port: setting.port&.to_i,
      domain: setting.domain,
      user_name: setting.user_name,
      password: setting.password,
      authentication: :plain,
      enable_starttls_auto: true
    }
  end
end
