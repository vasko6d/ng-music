class SessionsController < ApplicationController

  before_action :authenticate_user, :only => [:home, :profile, :setting]
  before_action :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"	
    end
  end

  def logout
  	  session[:user_id] = nil
      redirect_to :action => 'login'
  end

  def home
  	@singer = Singer.search(params[:search])
  	@album = Album.search(params[:search])
  end
end
