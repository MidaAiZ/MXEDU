class Manage::AppointsController < ManageController
    before_action :require_login

    def index
        count = params[:count] || 20
        page = params[:page] || 1
        if params[:user_id]
            @user = Index::User.find params[:user_id]
            nonpaged_appoints = @user.appoints.includes(:user, :product)
            @appoints = nonpaged_appoints.page(page).per(count)
        else
            nonpaged_appoints = Index::Appoint.all
            @appoints = nonpaged_appoints.page(page).per(count).includes(:user, :product)
        end
    end
end
