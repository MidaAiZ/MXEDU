class Manage::MaterialsController < ManageController
  before_action :require_login
  before_action :set_material, only: [:show, :edit, :update, :destroy, :upload, :uploader, :delete_file]
  before_action :set_select_cache, only: [:index, :new, :edit, :deleted_index]

  # GET /index/materials
  # GET /index/materials.json
  def index
    count = params[:count] || 20
    page = params[:page] || 1
    cons = params.slice(:name, :school, :cate, :tag, :grade)
    nonpaged_materials = Index::Material.sort(cons)
    @materials = nonpaged_materials.page(page).per(count).includes(:school, :cate, :admin)
  end

  # GET /index/materials/1
  # GET /index/materials/1.json
  def show
  end

  # GET /index/materials/new
  def new
    @material = Index::Material.new
  end

  # GET /index/materials/1/edit
  def edit
  end

  # POST /index/materials
  # POST /index/materials.json
  def create
	prms = material_params
    @material = Index::Material.new(prms)
	@material.admin = @admin
	@material.need_login = prms[:need_login] ? true : false

    respond_to do |format|
      if @material.save
        format.html { render html: manage_material_upload_path(@material) }
        format.json { render json: { url: manage_material_upload_path(@material) }, status: :created }
      else
        set_select_cache
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload

  end

  def uploader
      @file = Manage::MaterialFile.upload(params, @material)
      respond_to do |format|
        if @file.save
          format.html { render html: manage_material_path(@material) }
          format.json { render json: { code: :Success } }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @material.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /index/materials/1
  # PATCH/PUT /index/materials/1.json
  def update
	  prms = material_params
	  @material.need_login = prms[:need_login] ? true : false
	  respond_to do |format|
		if @material.update(prms)
		  format.html { render html: manage_material_upload_path(@material) }
		  format.json { render :show, status: :ok, location: @material }
		else
          set_select_cache
		  format.html { render :edit, status: :unprocessable_entity }
		  format.json { render json: @material.errors, status: :unprocessable_entity }
		end
	  end
  end

  def download
      @file = Manage::MaterialFile.find params[:file_id]
      file_path = "#{Rails.root}/public#{@file.file.url}"
      file_name = params[:filename]; file_name += ".#{params[:format]}" if params[:format]
      send_file(file_path, filename: file_name)
  end

  # DELETE /index/materials/1
  # DELETE /index/materials/1.json
  def destroy
    @material.update is_deleted: true
    respond_to do |format|
      format.html { redirect_to materials_url, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_file
    @file = @material.files.find_by_id params[:file_id]
    @file.destroy
    respond_to do |format|
      format.html { redirect_to materials_url, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deleted_index
      count = params[:count] || 20
      page = params[:page] || 1
      cons = params.slice(:name, :school, :cate, :tag, :grade)
      nonpaged_materials = Index::Material.sort(cons).deleted
      @materials = nonpaged_materials.page(page).per(count).includes(:school, :cate, :admin)
  end

  def recover
      @material = Index::Material.with_del.find(params[:material_id])
      @material.update is_deleted: false
      respond_to do |format|
        format.html { redirect_to manage_material_url(@material) }
        format.json { head :no_content }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Index::Material.with_del.find(params[:id] || params[:material_id])
      redirect_to "/material_404" and return if @material.is_deleted
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:name, :cate_id, :tag, :school_id, :intro, :details, :cover, :attach, :recommend, :grade, :need_login)
    end

    def set_select_cache
        info = Rails.cache.fetch("#{cache_key}", expires_in: 1.minutes) do
            {
                schools: Manage::School.all,
                cates: Manage::MaterialCate.all
            }
        end
        @schools = info[:schools]
        @cates = info[:cates]
    end
end
