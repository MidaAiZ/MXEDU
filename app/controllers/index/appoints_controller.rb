class Index::AppointsController < IndexController
  before_action :require_login
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

  # PATCH/PUT /index/appoints/1
  # PATCH/PUT /index/appoints/1.json
  def update
    respond_to do |format|
      if @appoint.update(index_appoint_params)
        format.html { redirect_to @appoint, notice: 'Appoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @appoint }
      else
        format.html { render :edit }
        format.json { render json: @appoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /index/appoints/1
  # DELETE /index/appoints/1.json
  def destroy
    @appoint.destroy
    respond_to do |format|
      format.html { redirect_to index_appoints_url, notice: 'Appoint was successfully destroyed.' }
      format.json { head :no_content }
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
