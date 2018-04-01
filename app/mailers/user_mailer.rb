class UserMailer < ApplicationMailer

  def password_reset(email, token)
    @email = email
    @token = token
  
    mail(to: email,
      subject: "FirstTouch Reset Password")
  end
end
