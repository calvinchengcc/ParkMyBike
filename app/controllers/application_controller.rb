class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :is_logged_in

  protected
  def authenticate_user 
    if session[:user_id] && User.exists?(session[:user_id])
        @current_user = User.find(session[:user_id])
        return true
    else
        redirect_to(:controller => 'sessions', :action => 'login')
        return false
    end
  end

  def save_login_state
    if session[:user_id] && User.exists?(session[:user_id])
        redirect_to(:controller => 'sessions', :action => 'home')
        return false
    else
        return true
    end
  end

  def is_logged_in
    if session[:user_id] && User.exists?(session[:user_id])
      return User.find(session[:user_id]).username
    else
      return false
    end
  end

end
