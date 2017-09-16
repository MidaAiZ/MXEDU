class Manage::MatHistoriesController < ManageController
	before_action :require_login
	before_action :set_history, only: :show

	def index
	  count = params[:count] || 20
      page = params[:page] || 1
	  if params[:user_id]
		@user = Index::User.find params[:user_id]
		nonpaged_histories = @user.mat_histories.includes(:user)
		@histories = nonpaged_histories.page(page).per(count)
	  else
		nonpaged_histories = Index::MatHistory.all.includes(:user)
		@histories = nonpaged_histories.page(page).per(count)
	  end
	end

	def show

	end

	private
	def set_history
		@history = Index::MatHistory.find_by_id params[:id]
		@code = 404 unless @history
	end
end
