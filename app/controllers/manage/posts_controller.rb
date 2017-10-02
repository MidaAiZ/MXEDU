class Manage::PostsController < ManageController
  before_action :require_login
  before_action :check_super, only: [:destroy]
  before_action :set_post, only: [:show, :destroy]

  # GET /index/posts
  # GET /index/posts.json
  def index
	count = params[:count] || 10
	page = params[:page] || 1
	cons = params.slice(:content, :school, :cate, :tag)
	nonpaged_posts = Index::Post.sort(cons)
	@posts = nonpaged_posts.page(page).per(count).includes(:school, :cate)
	set_cdts
    render(:_lists, layout: false) and return if params["dl"]
  end

  def index_deleted
	count = params[:count] || 10
  	page = params[:page] || 1
  	cons = params.slice(:content, :school, :cate, :tag)
  	nonpaged_posts = Index::Post.sort(cons).deleted
  	@posts = nonpaged_posts.page(page).per(count).includes(:school, :cate)
  	set_cdts
	@type = :deleted
	render :index
  end

  def index_forbidden
	count = params[:count] || 10
  	page = params[:page] || 1
  	cons = params.slice(:content, :school, :cate, :tag)
  	nonpaged_posts = Index::Post.sort(cons).forbidden
  	@posts = nonpaged_posts.page(page).per(count).includes(:school, :cate)
  	set_cdts
	@type = :forbidden
	render :index
  end

  def search
	@type = params[:type]
	@placeholder = "搜索关键词"
	@placeholder = '搜索用户删除的帖子' if @type == 'deleted'
	@placeholder = '搜索管理员删除的帖子' if @type == 'forbidden'
  end

  # GET /index/posts/1
  # GET /index/posts/1.json
  def show
    count = params[:count] || 10
    page = params[:page] || 1
    nonpaged_comments = @post.comments
    @comments = nonpaged_comments.page(page).per(count).includes(:user)
    @post.update readtimes: ((@post.readtimes || 0) + 1)
  end

  # DELETE /index/posts/1
  # DELETE /index/posts/1.json
  def destroy
	if @post.is_deleted? || @post.is_forbidden?
	else
		code = @post.forbid!
	end

    respond_to do |format|
      format.html { redirect_to "#{manage_posts_url}?page=#{params[:page]}" }
      format.json { head :no_content, status: code ? 200 : 422 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Index::Post.with_all.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :content, :images)
    end

	def set_cdts
        return false if params[:pjax] == 'true'
        s_id = @user.school_id if @user
        cons = Rails.cache.fetch("#{cache_key}_#{s_id}_cd", expires_in: 10.minutes) do
          {
            schools: s_id ? Manage::School.where(id: s_id) + (Manage::School.where.not(id: s_id)).limit(5) : Manage::School.limit(6),
            cates: Manage::PostCate.limit(6),
          }
        end
        @schools = cons[:schools]
        @cates = cons[:cates]
    end

end
