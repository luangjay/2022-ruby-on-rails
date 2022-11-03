class MainController < ApplicationController
  def login
    if session[:uid]
      @user = User.find(session[:uid])
    end
  end

  def authenticate
    u = User.where(login: params[:login]).first
    if u && u.authenticate(params[:password])
      session[:uid] = u.id
    end
    redirect_to main_login_path
  end

  def logout
    session[:uid] = nil
    redirect_to main_login_path
  end
  
end
