class AuthMailer < ActionMailer::Base

  default from: "noreply@toprater.com", template_path: 'mail/auth'

  def change_password email, token
    @token = token
    mail to: email, subject: "Password reset at Toprater.com"
  end

end
