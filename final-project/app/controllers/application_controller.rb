class ApplicationController < ActionController::Base
  def login?
    return session[:uid]!=nil
  end

  def require_login
    if login?
      return true
    else
      redirect_to login_path, notice: 'You must login first!'
    end
  end

  def require_user_type user_type
    return User.find(session[:uid]).user_type==user_type
  end
end
