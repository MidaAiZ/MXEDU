class Manage::SchoolsController < ManageController
  before_action :require_login
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /manage/schools
  # GET /manage/schools.json
  def index
    @schools = Manage::School.all
  end

  # GET /manage/schools/1
  # GET /manage/schools/1.json
  def show
  end

  # GET /manage/schools/new
  def new
    @school = Manage::School.new
  end

  # GET /manage/schools/1/edit
  def edit
  end

  # POST /manage/schools
  # POST /manage/schools.json
  def create
    @school = Manage::School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/schools/1
  # PATCH/PUT /manage/schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/schools/1
  # DELETE /manage/schools/1.json
  def destroy
    if (@school.materials.count == 0) && (@school.products.count == 0) && (@school.students.count == 0)
      @school.destroy
      @code = 'Success'
    end
    respond_to do |format|
      if @code
        format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
        format.json { head :no_content }
      else
         format.html { redirect_to schools_url, notice: '删除失败,该院校已经绑定相关资料', status: 422 }
        format.json { render json: { error: '删除失败,该院校已经绑定相关资料' }, status: 422 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = Manage::School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:city, :name, :cate, :sign, :info)
    end
end
