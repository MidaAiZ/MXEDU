class Manage::AppointsController < ManageController
	before_action :require_login
	
	def index
		count = params[:count] || 15
		page = params[:page] || 1

		nonpaged_appoints = Index::Appoint.all
		@appoints = nonpaged_appoints.page(page).per(count)
	end
end
