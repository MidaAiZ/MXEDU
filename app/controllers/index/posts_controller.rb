class Index::PostsController < IndexController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  # GET /index/posts
  # GET /index/posts.json
  def index
	count = params[:count] || 20
	page = params[:page] || 1
	cons = set_rec_cons params.slice(:name, :school, :cate)
	nonpaged_posts = Index::Post.sort(cons)
	@posts = nonpaged_posts.page(page).per(count).includes(:school, :cate)
	set_title((params[:cate] && (@cate = Manage::PostCate.find_by_id params[:cate])) ? @cate.name : "校园BBS")
	set_cdts
  end

  # GET /index/posts/1
  # GET /index/posts/1.json
  def show
	set_title @post.name
  end

  # GET /index/posts/new
  def new
    @post = Index::Post.new
	set_title "发布帖子"
  end

  # GET /index/posts/1/edit
  def edit
	set_title "修改 #{@post.name}"
  end

  # POST /index/posts
  # POST /index/posts.json
  def create
    @post = Index::Post.new(post_params)
	@post.user = @user
	@post.school = @user.school

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/posts/1
  # PATCH/PUT /index/posts/1.json
  def update
	unless @post.is_forbidden? # 被后台拉黑的帖子禁止更新
	  code = 'Success' if @post.update(post_params)
	end
	code ||= 'Fail'
    respond_to do |format|
      if code == 'Success'
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /index/posts/1
  # DELETE /index/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Index::Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:index_post).permit(:name, :content, :readtimes, :comments_count, :thumbs_count)
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

    def set_rec_cons cons
        cons[:school] = @user.school_id if @user && cons[:school].nil? # 院校资料推荐
        cons
    end
end
