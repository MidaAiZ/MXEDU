class Index::PostsController < IndexController
  before_action :check_login, except: [:new, :create, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :thumb_up, :thumb_cancel, :read]

  # GET /index/posts
  # GET /index/posts.json
  def index
	count = params[:count] || 10
	page = params[:page] || 1
    cons = set_rec_cons params.slice(:keyword, :school, :cate, :tag)
    nonpaged_posts = Index::Post.sort(cons).published.hot
    @posts = nonpaged_posts.page(page).per(count).includes(:user, :cate)
    if page.to_i == 1 && !params[:search]
        @posts = Index::Post.top.hot + @posts
        get_notices unless params["dl"] # 公告
    end
	set_title((params[:cate] && (@cate = Manage::PostCate.find_by_id params[:cate])) ? @cate.name : "校园BBS")
	# set_cdts
    render(:_lists, layout: false) and return if params["dl"]
  end

  def search

  end

  def hots #热门
    cons = set_rec_cons
  	@posts = Index::Post.sort(cons).state_ok.limit(20)
  end

  # GET /index/posts/1
  # GET /index/posts/1.json
  def show
    count = params[:count] || 10
    page = params[:page] || 1
    nonpaged_comments = @post.comments
    @comments = nonpaged_comments.page(page).per(count).includes(:user)
    @post.read! if params[:share]
	set_title @post.title
  end

  # GET /index/posts/new
  def new
    @post = Index::Post.new
    # get_cates
	set_title "发布帖子"
  end

  # GET /index/posts/1/edit
  def edit
    # get_cates
	set_title "修改 #{@post.title}"
  end

  # POST /index/posts
  # POST /index/posts.json
  def create
    @post = Index::Post.new(post_params)
	@post.user = @user
	@post.school = @user.school
    @post.state = @post.publish_state
	@post.images = params[:post][:images]

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post) }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/posts/1
  # PATCH/PUT /index/posts/1.json
  def update
    prms = post_params

	unless @post.is_forbidden? # 被后台拉黑的帖子禁止更新
      @post.images = params[:post][:images]
      @post.title = prms[:title]
      @post.tag = prms[:tag]
      @post.record_timestamps = false # 不更新时间戳
	  code = 'Success' if @post.update(prms)
	end
	code ||= 'Fail'
    respond_to do |format|
      if code == 'Success'
        format.html { redirect_to post_url @post }
        format.json { render :show, status: :created }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def thumb_up
    code = (@user ? Index::Thumb.thumb_up(@user, @post) : Index::Thumb.thumb_up(request.remote_ip, @post, 'ip'))

    respond_to do |format|
      format.html { render json: { }, status: code ? 200 : 422 }
      format.json { head :no_content, status: code ? 200 : 422  }
    end
  end

  def thumb_cancel
    @thumb = @post.has_thumb? @user, request.remote_ip
    code = @thumb.cancel if @thumb
    respond_to do |format|
      format.html { render json: { code: code } }
      format.json { head :no_content, status: code ? 200 : 422 }
    end
  end

  # DELETE /index/posts/1
  # DELETE /index/posts/1.json
  def destroy
    @post = @user.posts.find(params[:id])
    @post.del!
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def read
    @post.read!
    render json: { readtimes: @post.readtimes }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Index::Post.with_all.find(params[:id])
      redirect_to "/post_404" and return unless @post.state_ok?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :images, :tag, :cate_id)
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

    def set_rec_cons cons = {}
        cons[:school] = @user.school_id if @user && cons[:school].nil? # 院校资料推荐
        cons
    end

    def get_notices
        @notices = Rails.cache.fetch("#{cache_key}_notice", expires_in: 10.minutes) do
          Manage::PostNotice.limit(3)
        end
    end

    def get_cates
        @cates = Rails.cache.fetch("#{cache_key}_cate", expires_in: 10.minutes) do
          Manage::PostCate.limit(8)
        end
    end
end
