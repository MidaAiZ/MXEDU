class Index::UserCenterController < IndexController
	before_action :require_login

	def index
		set_title "个人中心"
	end

	def orders
		count = params[:count] || 20
	    page = params[:page] || 1

	    nonpaged_orders = @user.orders
	    @orders = nonpaged_orders.page(page).per(count)
	end

	def order
		@order = @user.orders.find_by_id params[:id]
		@code = 404 unless @order
	end

	def histories
	  count = params[:count] || 20
      page = params[:page] || 1

  	  nonpaged_histories = @user.histories
      @histories = nonpaged_histories.page(page).per(count).includes(:product)
	  set_title "浏览记录"
	end

	def history
		@history = @user.histories.find_by_id params[:id]
		@code = 404 unless @history
	end

end
