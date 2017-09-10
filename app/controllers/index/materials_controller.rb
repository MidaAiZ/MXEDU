class Index::MaterialsController < IndexController
  before_action :check_login
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /index/materials
  # GET /index/materials.json
  def index
    count = params[:count] || 20
    page = params[:page] || 1

    nonpaged_materials = Index::Material.sort(params[:type])
    @materials = nonpaged_materials.page(page).per(count)
  end

  # GET /index/materials/1
  # GET /index/materials/1.json
  def show
    @likes = Index::Material.sort(@material.cate).where.not(id: @material.id).limit(5)
    if !@user && @material.need_login
      Cache.new[request.remote_ip + '_history'] = request.url
    end
  end

  def download
      @file = Manage::MaterialFile.find params[:file_id]
      redirect_to login_path and return if (!@user && @file.material.need_login)
      file_path = "#{Rails.root}/public#{@file.file.url}"
      file_name = params[:filename]; file_name += ".#{params[:format]}" if params[:format]
      send_file(file_path, filename: file_name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Index::Material.find(params[:id])
    end
end
