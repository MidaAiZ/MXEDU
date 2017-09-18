class IndexController < ApplicationController
    layout 'index'
    before_action :check_login

    def check_login
       @user = Index::User.find_by_id session[:user_id]
    end

    def require_login
      redirect_to login_path and return unless check_login
    end

    def set_title title
        @title = title
    end
end
