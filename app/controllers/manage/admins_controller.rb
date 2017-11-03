class Manage::AdminsController < ManageController
  before_action :require_login
  before_action :check_super, except: [:profile, :update_avatar]
  before_action :set_manage_admin, only: [:update, :destroy]

  # GET /manage/admins
  # GET /manage/admins.json
  def index
    @admins = Manage::Admin.un_deleted.all
  end

  def profile
  end

  # POST /manage/admins
  # POST /manage/admins.json
  def create
    @edit_admin = Manage::Admin.new(manage_admin_params)
    @edit_admin.role = 'common'

    respond_to do |format|
      if @edit_admin.save
        format.html { redirect_to @edit_admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @edit_admin }
      else
        format.html { render :new }
        format.json { render json: @edit_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/admins/1
  # PATCH/PUT /manage/admins/1.json
  def update
    respond_to do |format|
      if @edit_admin.update(manage_admin_params)
        format.html { redirect_to @edit_admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @edit_admin }
      else
        format.html { render :edit }
        format.json { render json: @edit_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_avatar
    prms = params
    @admin.x = prms[:x]
    @admin.y = prms[:y]
    @admin.width = prms[:width]
    @admin.height = prms[:height]
    @admin.rotate = prms[:rotate]
    avatar = prms[:avatar]
    avatar = @admin.avatar.thumb if avatar.blank?
    respond_to do |format|
      if @admin.update(avatar: avatar)
        format.json { render :show }
      else
        format.json { render json: @admin.errors }
      end
    end
  end


  # DELETE /manage/admins/1
  # DELETE /manage/admins/1.json
  def destroy
    unless @edit_admin.super?
        @code = @edit_admin.update(is_deleted: true)
    end
    respond_to do |format|
      if @code
        format.html { redirect_to manage_material_cates_path, notice: 'MaterialCate was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to manage_material_cates_path, notice: '删除失败,无法删除超级管理员', status: 422 }
        format.json { render json: { error: '删除失败,无法删除超级管理员' }, status: 422 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_admin
      @edit_admin = Manage::Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manage_admin_params
      params.require(:admin).permit(:number, :password, :name)
    end
end
