class Manage::SessionController < ManageController
    def index
		
    end

    def login
        prms = params[:admin]
        if prms[:number] && prms[:password]
          if @admin = Manage::Admin.find_by_id(prms[:number]).try(:authenticate, prms[:password])
            session[:admin_id] = @admin.id
            @code = 'Success'
          end
        end
    end

    def logout
      session[:admin_id] = nil
    end
end
