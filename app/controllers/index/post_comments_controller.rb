class Index::PostCommentsController < IndexController
  before_action :require_login, only: [:new, :create, :destroy]
  before_action :check_login, except: [:new, :create, :destroy]
  before_action :set_post, only: [:new, :index, :create, :show]
  before_action :set_post_comment, only: [:show]


  def new
    @comment = Index::PostComment.new
  end
  # GET /index/post_comments
  # GET /index/post_comments.json
  def index
    @nonpaged_comments = @post.comments
    @comments = @nonpaged_comments.page(params[:page]).per(15)

    respond_to do |format|
      format.json { render :index }
      format.html { render :index, formats: [:json] }
    end
  end

  # GET /index/post_comments/1
  # GET /index/post_comments/1.json
  def show
  end

  # POST /index/post_comments
  # POST /index/post_comments.json
  def create
    @comment = Index::PostComment.new(post_comment_params)
    @comment.images = params[:comment][:images]
    respond_to do |format|
      if @comment._save @user, @post
        format.html { redirect_to post_comment_path(@comment), notice: 'Post comment was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def thumb_up
    @comment = Index::PostComment.find(params[:id])
    code = (@user ? Index::Thumb.thumb_up(@user, @comment) : Index::Thumb.thumb_up(request.remote_ip, @comment, 'ip'))

    respond_to do |format|
      format.html { render json: { }, status: code ? 200 : 422 }
      format.json { head :no_content, status: code ? 200 : 422  }
    end
  end

  def thumb_cancel
    @comment = Index::PostComment.find(params[:id])
    @thumb = @comment.has_thumb? @user.id, request.remote_ip
    code = @thumb.cancel if @thumb
    respond_to do |format|
      format.html { render json: { code: code }, status: code ? 200 : 422 }
      format.json { head :no_content, status: code ? 200 : 422 }
    end
  end

  # DELETE /index/post_comments/1
  # DELETE /index/post_comments/1.json
  def destroy
    @comment = @user.post_comments.find(params[:id])
    @comment._destroy
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post_id), notice: 'Post comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
        @post = Index::Post.find(params[:post_id])
    end

    def set_post_comment
      @comment = @post.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_comment_params
      params.require(:comment).permit(:content)
    end
end
