class Manage::MaterialCatesController < ManageController
  before_action :require_login
  before_action :set_material_cate, only: [:show, :edit, :update, :destroy]

  # GET /manage/material_cates
  # GET /manage/material_cates.json
  def index
    @material_cates = Manage::MaterialCate.all
  end

  # GET /manage/material_cates/1
  # GET /manage/material_cates/1.json
  def show
  end

  # GET /manage/material_cates/new
  def new
    @material_cate = Manage::MaterialCate.new
  end

  # GET /manage/material_cates/1/edit
  def edit
  end

  # POST /manage/material_cates
  # POST /manage/material_cates.json
  def create
    @material_cate = Manage::MaterialCate.new(material_cate_params)

    respond_to do |format|
      if @material_cate.save
        format.html { redirect_to @material_cate, notice: 'MaterialCate was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @material_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/material_cates/1
  # PATCH/PUT /manage/material_cates/1.json
  def update
    respond_to do |format|
      if @material_cate.update(material_cate_params)
        format.html { redirect_to @material_cate, notice: 'MaterialCate was successfully updated.' }
        format.json { render :show, status: :ok, location: @material_cate }
      else
        format.html { render :edit }
        format.json { render json: @material_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/material_cates/1
  # DELETE /manage/material_cates/1.json
  def destroy
    if @material_cate.materials.empty?
      @material_cate.update is_deleted: true
      @code = 'Success'
    end
    respond_to do |format|
      if @code
        format.html { redirect_to material_cates_url, notice: 'MaterialCate was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to material_cates_url, notice: '删除失败,该分类已经绑定相关资料', status: 422 }
        format.json { render json: { error: '删除失败,该分类已经绑定相关资料' }, status: 422 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_cate
      @material_cate = Manage::MaterialCate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_cate_params
      params.require(:material_cate).permit(:name)
    end
end
