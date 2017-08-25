class Manage::OrdersController < ManageController
	before_action :require_login
	before_action :set_order, only: :show

	def index
	  count = params[:count] || 15
      page = params[:page] || 1

	  nonpaged_orders = Index::Order.all
      @orders = nonpaged_orders.page(page).per(count)
	end

	def show

	end

	private
	def set_order
		@order = Index::Order.find_by_id params[:id]
		@code = 404 unless @order
	end
end
