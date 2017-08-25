class Manage::HistoriesController < ManageController
	before_action :require_login
	before_action :set_history, only: :show

	def index
	  count = params[:count] || 15
      page = params[:page] || 1

	  nonpaged_histories = Index::History.all.includes(:user)
      @histories = nonpaged_histories.page(page).per(count)
	end

	def show

	end

	private
	def set_history
		@history = Index::Order.find_by_id params[:id]
		@code = 404 unless @history
	end
end
