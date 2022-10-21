class ApplicationController < ActionController::Base
  private
    def login?
      return session[:login]==true
    end
    def require_login
      if login?
        return true
      else
        redirect_to main_login_path, notice: 'You must login first!'
      end
    end
end
