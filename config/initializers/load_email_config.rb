# Email config for send email
Rails.application.configure do
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    # SMTP settings for gmail
    config.action_mailer.smtp_settings = {
        :address              => APP_CONFIG['server_smtp'],
        :port                 => 25,
        :user_name            => APP_CONFIG['gmail_username'],
        :password             => APP_CONFIG['gmail_password'],
        :authentication       => "plain",
        :enable_starttls_auto => true
    }
end