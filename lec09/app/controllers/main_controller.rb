class MainController < ApplicationController
  def login
    
  end

  def authenticate
    u = User.where(login: params[:login]).first
    if u && u.authenticate(params[:password])
      session[:login] = true
    end
    redirect_to main_login_path
  end

  def logout
    session[:login] = false
    redirect_to main_login_path
  end
end
