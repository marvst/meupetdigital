class AuthController < ApplicationController
  def login
    # Show login form
  end

  def create
    email = params[:email]&.strip&.downcase
    
    if email.blank?
      flash.now[:error] = "Please enter your email address"
      render :login, status: :unprocessable_entity
      return
    end
    
    # Find or create user
    user = User.find_by_email(email)
    
    unless user
      user = User.create!(email: email, name: email.split('@').first)
    end
    
    # Generate auth token
    auth_token = AuthToken.generate_for_user(user)
    
    # Send authentication email
    AuthMailer.login_email(user, auth_token).deliver_now
    
    flash[:notice] = "Check your email for a login link!"
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:error] = "Invalid email address"
    render :login, status: :unprocessable_entity
  end
end
