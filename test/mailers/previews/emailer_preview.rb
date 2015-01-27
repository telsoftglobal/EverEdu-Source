# Preview all emails at http://localhost:3000/rails/mailers/emailer
class EmailerPreview < ActionMailer::Preview
  def sample_mail_preview
    Emailer.send_email('cuongct@telsoft.com.vn','CuongCT')
  end

end
