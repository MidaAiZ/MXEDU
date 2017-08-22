class IndexController < ApplicationController
    layout 'index'

    def check_login
      session[:user_id]
    end

    def require_login
      redirect_to login_path and return unless check_login
      @user = Index::User.find session[:user_id]
    end

end
