class Manage::PostCatesController < ManageController
  before_action :require_login
  before_action :set_post_cate, only: [:show, :edit, :update, :destroy]

  # GET /manage/post_cates
  # GET /manage/post_cates.json
  def index
    @post_cates = Manage::PostCate.all
  end

  # GET /manage/post_cates/1
  # GET /manage/post_cates/1.json
  def show
  end

  # GET /manage/post_cates/new
  def new
    @post_cate = Manage::PostCate.new
  end

  # GET /manage/post_cates/1/edit
  def edit
  end

  # POST /manage/post_cates
  # POST /manage/post_cates.json
  def create
    @post_cate = Manage::PostCate.new(post_cate_params)

    respond_to do |format|
      if @post_cate.save
        format.html { redirect_to @post_cate, notice: 'PostCate was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @post_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/post_cates/1
  # PATCH/PUT /manage/post_cates/1.json
  def update
    respond_to do |format|
      if @post_cate.update(post_cate_params)
        format.html { redirect_to @post_cate, notice: 'PostCate was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_cate }
      else
        format.html { render :edit }
        format.json { render json: @post_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/post_cates/1
  # DELETE /manage/post_cates/1.json
  def destroy
    if @post_cate.posts.count == 0
      @post_cate.destroy
      @code = 'Success'
    end
    respond_to do |format|
      if @code
        format.html { redirect_to post_cates_url, notice: 'PostCate was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to post_cates_url, notice: '删除失败,该分类已经绑定相关帖子', status: 422 }
        format.json { render json: { error: '删除失败,该分类已经绑定相关帖子' }, status: 422 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_cate
      @post_cate = Manage::PostCate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_cate_params
      params.require(:post_cate).permit(:name)
    end
end
