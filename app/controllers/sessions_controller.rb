class SessionsController < ApplicationController
  def callback
    token = params[:token]
    
    if token.blank?
      flash[:error] = "Invalid authentication link"
      redirect_to root_path
      return
    end
    
    auth_token = AuthToken.find_valid_token(token)
    
    if auth_token.nil?
      flash[:error] = "Invalid or expired authentication link"
      redirect_to root_path
      return
    end
    
    # Log in the user
    session[:user_id] = auth_token.user.id
    
    # Delete the used token
    auth_token.destroy
    
    flash[:notice] = "Welcome back, #{auth_token.user.name}!"
    redirect_to root_path
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to root_path
  end
end
