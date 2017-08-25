class Manage::UsersController < ManageController
	before_action :require_login

	def index
		count = params[:count] || 15
		page = params[:page] || 1

	 	nonpaged_users = Index::User.all
		@users = nonpaged_users.page(page).per(count)
	end
end
