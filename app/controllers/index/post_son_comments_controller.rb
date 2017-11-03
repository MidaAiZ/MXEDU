class Index::PostSonCommentsController < IndexController
	before_action :require_login, only: [:create]
	before_action :set_cmt, only: [:index, :show, :destroy, :thumb_up]
	before_action :set_post_son_comment, only: [:show, :destroy, :thumb_up]
	before_action :check_login, except: [:create]

	# GET /index/post_son_comments
	# GET /index/post_son_comments.json
	def index
	  @nonpaged_son_comments = @cmt.son_comments
	  @son_comments = @nonpaged_son_comments.page(params[:page]).per(15)

	  respond_to do |format|
		format.json { render :index }
		format.html { render :index, formats: [:json] }
	  end
	end

	# GET /index/post_son_comments/1
	# GET /index/post_son_comments/1.json
	def show
	end

	# POST /index/post_son_comments
	# POST /index/post_son_comments.json
	def create
	  @son_comment = Index::PostSonComment.new(post_son_comment_params)
	  respond_to do |format|
		if @son_comment._save @user, @cmt
		  format.html { redirect_to post_son_comment_path(@son_comment), notice: 'Post son_comment was successfully created.' }
		  format.json { render :show, status: :created }
		else
		  format.html { render :new }
		  format.json { render json: @son_comment.errors, status: :unprocessable_entity }
		end
	  end
	end

	def thumb_up
	  @user ? Index::Thumb.thumb_up(@user, @son_comment) : Index::Thumb.thumb_up(request.remote_ip, @son_comment, 'ip')

	  respond_to do |format|
		format.html { render json: { code: :Success } }
		format.json { head :no_content }
	  end
	end

	# DELETE /index/post_son_comments/1
	# DELETE /index/post_son_comments/1.json
	def destroy
	  @son_comment._destroy
	  respond_to do |format|
		format.html { redirect_to post_son_comments_path, notice: 'Post son_comment was successfully destroyed.' }
		format.json { head :no_content }
	  end
	end

	private
	  def set_cmt
		  @cmt = Index::PostComment.find(parmas[:post_comment_id])
	  end

	  def set_post_son_comment
		@son_comment = @cmt.son_comments.find(params[:id])
	  end

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def post_son_comment_params
		params.require(:comment).permit(:content)
	  end
end
