class Index::MaterialsController < IndexController
  before_action :check_login
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /index/materials
  # GET /index/materials.json
  def index
    count = params[:count] || 20
    page = params[:page] || 1
    cons = set_rec_cons params.slice(:name, :school, :cate, :tag, :grade)
    nonpaged_materials = Index::Material.sort(cons)
    @materials = nonpaged_materials.page(page).per(count).includes(:cate, :school)
    set_title((params[:cate] && (@cate = Manage::MaterialCate.find_by_id params[:cate])) ? @cate.name : "学习资料")
    set_cdts
    render(:_lists, layout: false) and return if params["dl"]
  end

  # GET /index/materials/1
  # GET /index/materials/1.json
  def show
    Index::MatHistory.add @user, @material, request.remote_ip
    @likes = Index::Material.sort({school: @material.school_id, cate: @material.cate_id}).where.not(id: @material.id).limit(5).includes(:cate)
    if !@user && @material.need_login
      Cache.new[request.remote_ip + '_history'] = request.url
    end
    set_title @material.name
  end

  def download
    begin
      @file = Manage::MaterialFile.find params[:file_id]
      redirect_to login_path and return if (!@user && @file.material.need_login)

      filepath = "#{Rails.root}/public#{@file.file.url}"
      filename = @file.name;
      send_file(filepath, filename: filename, content_type: @file.f_type, content_length: @file.size)
      @file.update dload_count: @file.dload_count + 1
      @file.material.update dload_count: (@file.material.dload_count + 1)
    rescue
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Index::Material.with_del.find(params[:id])
      redirect_to "/material_404" and return if @material.is_deleted
    end

    def set_cdts
        return false if params[:pjax] == 'true'
        s_id = @user.school_id if @user
        cons = Rails.cache.fetch("#{cache_key}_#{s_id}_cd", expires_in: 10.minutes) do
          {
            schools: s_id ? Manage::School.where(id: s_id) + (Manage::School.where.not(id: s_id)).limit(5) : Manage::School.limit(6),
            cates: Manage::MaterialCate.limit(6)
          }
        end
        @schools = cons[:schools]
        @cates = cons[:cates]
    end

    def set_rec_cons cons
        cons[:school] = @user.school_id if @user && cons[:school].nil? # 院校资料推荐
        # if @user.grade
        #
        # end
        cons
    end
end
