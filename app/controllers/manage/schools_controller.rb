class Manage::SchoolsController < ApplicationController
  before_action :set_manage_school, only: [:show, :edit, :update, :destroy]

  # GET /manage/schools
  # GET /manage/schools.json
  def index
    @manage_schools = Manage::School.all
  end

  # GET /manage/schools/1
  # GET /manage/schools/1.json
  def show
  end

  # GET /manage/schools/new
  def new
    @manage_school = Manage::School.new
  end

  # GET /manage/schools/1/edit
  def edit
  end

  # POST /manage/schools
  # POST /manage/schools.json
  def create
    @manage_school = Manage::School.new(manage_school_params)

    respond_to do |format|
      if @manage_school.save
        format.html { redirect_to @manage_school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @manage_school }
      else
        format.html { render :new }
        format.json { render json: @manage_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/schools/1
  # PATCH/PUT /manage/schools/1.json
  def update
    respond_to do |format|
      if @manage_school.update(manage_school_params)
        format.html { redirect_to @manage_school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @manage_school }
      else
        format.html { render :edit }
        format.json { render json: @manage_school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/schools/1
  # DELETE /manage/schools/1.json
  def destroy
    @manage_school.destroy
    respond_to do |format|
      format.html { redirect_to manage_schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_school
      @manage_school = Manage::School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manage_school_params
      params.require(:manage_school).permit(:city, :name, :cate, :sign, :info)
    end
end
