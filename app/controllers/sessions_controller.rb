class SessionsController < ApplicationController

  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]


  def login
  end

  def home
  end

  def profile
  end

  def setting
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user
        session[:user_id] = authorized_user.id
        flash.clear
        redirect_to bike_racks_path
    else
        flash[:alert] = "Invalid Username or Password"
        render "login"
    end
  end

  def logout
    session[:user_id] = nil
    session[:userF_id] = nil
    redirect_to :action => 'login'
  end

  def create
    userF = UserF.from_omniauth(env["omniauth.auth"])
    session[:userF_id] = userF.id
    render "profile"
  end

  def destroy
    session[:userF_id] = nil
    render "profile"
  end


end
