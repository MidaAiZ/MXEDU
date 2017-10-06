class Index::UserCenterController < IndexController
	before_action :require_login
	before_action :check_login , only: [:other_profile]

	def index
		@posts = @user.posts.limit(8)
		set_title "个人中心"
	end

	def posts
		count = params[:count] || 10
		page = params[:page] || 1
		nonpaged_posts = @user.posts
		@posts = nonpaged_posts.page(page).per(count).includes(:cate, :user)
		set_title("我的帖子")
	    render(:_post_lists, layout: false) and return if params["dl"]
	end

	def post_msgs
		count = params[:count] || 10
		page = params[:page] || 1
		nonpaged_msgs = @user.post_msgs
		@msgs = nonpaged_msgs.page(page).per(count).includes(:resource, :sender)
		@user.post_msgs.update_all state: Index::PostMsg.read_state
		Index::PostMsg.clear_unread_count @user
		set_title("我的消息")
	    render(:_post_msg_lists, layout: false) and return if params["dl"]
	end

	def delete_post_msg
		msg = @user.post_msgs.find(params[:id])
		msg.destroy
		render json: {}
	end

	def unread_post_msgs_count
		count = Index::PostMsg.unread_count @user
		render json: { count: count }
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

	private
	def unread_pmsgs_cache_key
		"#{@user.id}_unread_post_msgs_count"
	end
end
