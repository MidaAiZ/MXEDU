class Manage::PostNoticesController < ManageController
    before_action :require_login
    before_action :set_post_notice, only: [:show, :edit, :update, :destroy]
    before_action :set_select_cache, only: [:index, :new, :edit, :deleted_index]
    before_action :check_super, only: [:deleted_index, :recover]

    # GET /index/post_notices
    # GET /index/post_notices.json
    def index
        count = params[:count] || 20
        page = params[:page] || 1
        cons = params.slice(:title, :school, :cate)
        nonpaged_post_notices = Manage::PostNotice.sort(cons)
        @post_notices = nonpaged_post_notices.page(page).per(count).includes(:school, :admin)
    end

    # GET /index/post_notices/1
    # GET /index/post_notices/1.json
    def show

    end

    # GET /index/post_notices/new
    def new
      @post_notice = Manage::PostNotice.new
    end

    # GET /index/post_notices/1/edit
    def edit
    end

    # POST /index/post_notices
    # POST /index/post_notices.json
    def create
      @post_notice = Manage::PostNotice.new(post_notice_params)
      @post_notice.admin = @admin
      respond_to do |format|
        if @post_notice.save
          format.html { render html: manage_post_notice_path(@post_notice) }
          format.json { render :show, status: :created }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post_notice.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /index/post_notices/1
    # PATCH/PUT /index/post_notices/1.json
    def update
      respond_to do |format|
        if @post_notice.update(post_notice_params)
          format.html { render html: manage_post_notice_path(@post_notice) }
          format.json { render :show, status: :ok, location: @post_notice }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post_notice.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /index/post_notices/1
    # DELETE /index/post_notices/1.json
    def destroy
      @post_notice.update is_deleted: true
      respond_to do |format|
        format.html { redirect_to manage_post_notices_path, notice: 'PostNotice was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def deleted_index
        count = params[:count] || 20
        page = params[:page] || 1
        cons = params.slice(:title, :school, :cate)
        nonpaged_post_notices = Manage::PostNotice.sort(cons).deleted
        @post_notices = nonpaged_post_notices.page(page).per(count).includes(:school, :admin)
    end

    def recover
        @post_notice = Manage::PostNotice.with_del.find(params[:post_notice_id])
        @post_notice.update is_deleted: false
        respond_to do |format|
          format.html { redirect_to manage_post_notice_path(@post_notice) }
          format.json { head :no_content }
        end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post_notice
        @post_notice = Manage::PostNotice.with_del.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_notice_params
        params.require(:post_notice).permit(:title, :cate, :school_id, :content)
      end

      def set_select_cache
          return false if params[:pjax] == 'true'

          if @post_notice
            s_id =  @post_notice.school_id if @post_notice.school_id
          end

          info = Rails.cache.fetch("#{cache_key}_#{s_id}", expires_in: 1.minutes) do
              {
                  schools: s_id ? Manage::School.where(id: s_id) + (Manage::School.where.not(id: s_id)).limit(7) : Manage::School.limit(8),
              }
          end
          @schools = info[:schools]
      end
end
