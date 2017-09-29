class Index::ThumbsController < IndexController
	before_action :check_login
	before_action :set_thumb, only: [:destroy]

	# def create
	#
	# end

	def destroy
		if (@user && @thumb.user == @user) || @thumb.remote_ip == request.remote_ip
			@thumb.cancel
		end
		respond_to do |format|
		  format.html { reder json: { code: :Success } }
		  format.json { head :no_content }
		end
	end

	private

	def set_thumb
		@thumb = Index::Thumb.find_by_id params[:id]
	end
end
