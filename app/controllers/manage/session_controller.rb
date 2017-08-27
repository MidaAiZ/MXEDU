class Manage::SessionController < ManageController
    layout false

    def index

    end

    def login
        prms = params[:admin]
        if prms[:number] && prms[:password]
          if @admin = Manage::Admin.find_by_number(prms[:number]).try(:authenticate, prms[:password])
            session[:admin_id] = @admin.id
            @code = 'Success'
          end
        end
        puts @admin
        @code ||= "Fail"
        respond_to do |fomat|
            fomat.html { redirect_to manage_root_path }
            fomat.json { render json: { code: @code } }
        end
    end

    def logout
      session[:admin_id] = nil
      respond_to do |fomat|
        fomat.html { redirect_to manage_root_path }
        fomat.json { render json: { code: 'Success' } }
      end
    end
end
