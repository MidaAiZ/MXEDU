class Index::VisitUserController < IndexController
	before_action :check_login
	before_action :set_visited_user

	def index
		@posts = @visited_user.posts.limit(8)
		set_title "#{@visited_user}的个人中心"
	end

	def posts
		count = params[:count] || 10
		page = params[:page] || 1
		nonpaged_posts = @visited_user.posts
		@posts = nonpaged_posts.page(page).per(count)
		set_title("#{@visited_user.nickname}的帖子")
	    render(:_post_lists, layout: false) and return if params["dl"]
	end

	private

	def set_visited_user
		@visited_user = Index::User.find params[:id]
	end

end
