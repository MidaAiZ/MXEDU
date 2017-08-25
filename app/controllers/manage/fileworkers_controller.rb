class Manage::FileworkersController < ManageController
  before_action :require_login
  before_action :set_file, only: [:show, :destroy]

  def index
    # @nonpaged_files = Manage::Filewordker.order(created_at: :desc)
    # @files = @nonpaged_files.page(params[:page]).per(15)
	#
    # respond_to do |format|
    #   format.json { render :index }
    #   format.html { render :index, :formats=>[:json] }
    # end
  end

  def create
    @file = Manage::Fileworker.new(manage_fileworker_params)
    respond_to do |format|
      if @file.save
        # 只返回json
        format.json { render :show }
        format.html { render :show, :formats=>[:json] }
        # :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder]}
      else
        format.json { render nothing: true }
        format.html { render nothing: true }
      end
    end
  end

  def destroy
    # @file.destroy
    # respond_to do |format|
    #   format.json { render json: { success: true } }
    #   format.html { redirect_to :index }
    # end
  end

  def show
    respond_to do |format|
      format.json { render :show }
      format.html { render :show, :formats=>[:json] }
    end
  end

  private

  def manage_fileworker_params
    params.require(:manage_fileworker).permit(:file)
  end

  def set_file
    @file = Manage::Fileworker.find(params[:id])
  end
end
