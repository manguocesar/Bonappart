class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
  before_action :set_smtp_settings

  private

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
