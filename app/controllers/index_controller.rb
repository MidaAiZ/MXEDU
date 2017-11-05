class IndexController < ApplicationController
    layout 'index'
    before_action :check_login
    after_action :set_login_record

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

    def set_login_record
        key = login_cache_key
        unless ($redis.GET key)
            record = Manage::LoginRecord._create(request.remote_ip, @user)
            $redis.SET(key, record.id)
            $redis.EXPIRE key, 3*60*60 # 三小时重新计记录一次
        end
    end

    def login_cache_key
        @user ? "login_#{@user.id}_#{request.remote_ip}" : "login_#{request.remote_ip}"
    end
end
