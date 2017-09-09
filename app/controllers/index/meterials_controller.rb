class Index::MeterialsController < ApplicationController
  before_action :set_index_meterial, only: [:show, :edit, :update, :destroy]

  # GET /index/meterials
  # GET /index/meterials.json
  def index
    @index_meterials = Index::Meterial.all
  end

  # GET /index/meterials/1
  # GET /index/meterials/1.json
  def show
  end

  # GET /index/meterials/new
  def new
    @index_meterial = Index::Meterial.new
  end

  # GET /index/meterials/1/edit
  def edit
  end

  # POST /index/meterials
  # POST /index/meterials.json
  def create
    @index_meterial = Index::Meterial.new(index_meterial_params)

    respond_to do |format|
      if @index_meterial.save
        format.html { redirect_to @index_meterial, notice: 'Meterial was successfully created.' }
        format.json { render :show, status: :created, location: @index_meterial }
      else
        format.html { render :new }
        format.json { render json: @index_meterial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/meterials/1
  # PATCH/PUT /index/meterials/1.json
  def update
    respond_to do |format|
      if @index_meterial.update(index_meterial_params)
        format.html { redirect_to @index_meterial, notice: 'Meterial was successfully updated.' }
        format.json { render :show, status: :ok, location: @index_meterial }
      else
        format.html { render :edit }
        format.json { render json: @index_meterial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /index/meterials/1
  # DELETE /index/meterials/1.json
  def destroy
    @index_meterial.destroy
    respond_to do |format|
      format.html { redirect_to index_meterials_url, notice: 'Meterial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_meterial
      @index_meterial = Index::Meterial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_meterial_params
      params.require(:index_meterial).permit(:name, :cate, :tag, :info)
    end
end
