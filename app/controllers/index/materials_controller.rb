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

      begin
        filepath = "#{Rails.root}/public#{@file.file.url}"
        filename = @file.name;
        if Rails.env == 'production'
            return head(
                    'X-Accel-Redirect' => filepath,
                    'Content-Length' => @file.size,
                    'Content-Type' => @file.f_type,
                    'Content-Disposition' => "attachment; filename=\"#{@file.name}\""
                )
        else
            send_file(filepath, filename: filename, content_type: @file.f_type, content_length: @file.size)
        end
      rescue Exception
        redirect_to '/500'
      ensure
        logger.info response.headers
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Index::Material.find(params[:id])
    end
end
