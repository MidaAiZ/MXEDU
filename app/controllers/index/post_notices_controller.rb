class Index::PostNoticesController < IndexController
	before_action :check_login
	before_action :set_notice

	def show
		@notice.read!
	end

	private

	def set_notice
		@notice = Manage::PostNotice.find params[:id]
	end
end
