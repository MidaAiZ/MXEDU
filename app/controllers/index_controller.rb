class IndexController < ApplicationController
    layout 'index'

    def check_login
        unless session[:user_id]
            redirect_to login_path and return
        end
    end
end
