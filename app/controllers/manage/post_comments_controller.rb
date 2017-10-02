class Manage::PostCommentsController < ManageController
  before_action :require_login
  before_action :check_super, only: [:destroy]
  before_action :set_post, only: [:index, :show]
  before_action :set_post_comment, only: [:show]


  # GET /index/post_comments
  # GET /index/post_comments.json
  def index
    count = params[:count] || 10
    page = params[:page] || 1

    @nonpaged_comments = @post.comments
    @comments = @nonpaged_comments.page(page).per(count)
    render("/manage/posts/_cmt_lists", layout: false) and return if params[:dl]
  end

  # GET /index/post_comments/1
  # GET /index/post_comments/1.json
  def show
  end

  # DELETE /index/post_comments/1
  # DELETE /index/post_comments/1.json
  def destroy
    @comment = Index::PostComment.find(params[:id])
    @comment._destroy
    respond_to do |format|
      format.html { redirect_to manage_post_path(@comment.post_id), notice: 'Post comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
        @post = Index::Post.with_all.find(params[:post_id])
    end

    def set_post_comment
      @comment = @post.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_comment_params
      params.require(:comment).permit(:content)
    end
end
