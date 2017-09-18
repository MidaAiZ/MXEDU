class Index::AppointsController < IndexController
  before_action :check_login, only: :create
  before_action :require_login, except: :create
  before_action :set_index_appoint, only: [:show, :edit, :update, :destroy]


  # POST /index/appoints
  # POST /index/appoints.json
  def create
    @appoint = Index::Appoint.new(index_appoint_params)
	@appoint.user = @user

    respond_to do |format|
      if @appoint.save
        @code = 'Success'
        format.html { redirect_to @appoint, notice: 'Appoint was successfully created.' }
        format.json { render json: { code: @code } }
      else
        @code = 'Fail'
        format.html { render :new }
        format.json { render json: { code: @code, errors: @appoint.errors } }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_appoint
      @appoint = Index::Appoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_appoint_params
      params.require(:appoint).permit(:name, :phone, :content, :time, :product_id)
    end
end
