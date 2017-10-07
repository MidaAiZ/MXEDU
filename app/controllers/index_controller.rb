class IndexController < ApplicationController
    layout 'index'
    before_action :check_login

    def check_login
        user_cache session[:user_id]
        @user
    end

    def require_login
      redirect_to login_path and return unless check_login
    end

    def set_title title
        @title = title
    end

    def user_cache id
        @user = Cache.new["logged_user_#{id}"]
        unless @user
            @user = Index::User.find_by_id id
            Cache.new["logged_user_#{id}"] = @user if @user
        end
    end
end
