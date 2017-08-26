class ManageController < ApplicationController
    layout 'manage'

    def check_login
      @admin = Manage::Admin.find_by_id session[:admin_id]
    end

    def require_login
        redirect_to manage_login_path and return unless check_login
    end

    def can? role
        role.include? @admin.role.to_sym
    end

    def check_super
        unless @admin.super?
         respond_to do |fomat|
             fomat.json { render json: { count: :NoPermission} }
             fomat.html { redirect_to :manage_root_path, notice: :NoPermission }
         end
         return
        end
    end

end
