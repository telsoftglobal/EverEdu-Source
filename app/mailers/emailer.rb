class Emailer < ActionMailer::Base
  default from: APP_CONFIG['gmail_username']

  def send_email(email,name)
    @name = name
    mail(to: email, subject: 'Sample Email')
  end

  def send_email_change_password(user)
    @user = user
    mail(to: @user.email, subject: 'Confirm password')
  end

  def send_email_generate_password(user,password)
    @user = user
    @password = password
    mail(to: @user.email, subject: password)
  end

end
