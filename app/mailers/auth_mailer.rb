class AuthMailer < ApplicationMailer
  default from: 'noreply@meupet.digital'
  
  def login_email(user, auth_token)
    @user = user
    @auth_token = auth_token
    @login_url = sessions_callback_url(token: @auth_token.token)
    
    mail(
      to: @user.email,
      subject: "Login to MeuPetDigital"
    )
  end
end
