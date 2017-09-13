class Manage::ProductCatesController < ManageController
  before_action :require_login
  before_action :set_product_cate, only: [:show, :edit, :update, :destroy]

  # GET /manage/product_cates
  # GET /manage/product_cates.json
  def index
    @product_cates = Manage::ProductCate.all
  end

  # GET /manage/product_cates/1
  # GET /manage/product_cates/1.json
  def show
  end

  # GET /manage/product_cates/new
  def new
    @product_cate = Manage::ProductCate.new
  end

  # GET /manage/product_cates/1/edit
  def edit
  end

  # POST /manage/product_cates
  # POST /manage/product_cates.json
  def create
    @product_cate = Manage::ProductCate.new(product_cate_params)

    respond_to do |format|
      if @product_cate.save
        format.html { redirect_to @product_cate, notice: 'ProductCate was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @product_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/product_cates/1
  # PATCH/PUT /manage/product_cates/1.json
  def update
    respond_to do |format|
      if @product_cate.update(product_cate_params)
        format.html { redirect_to @product_cate, notice: 'ProductCate was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_cate }
      else
        format.html { render :edit }
        format.json { render json: @product_cate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/product_cates/1
  # DELETE /manage/product_cates/1.json
  def destroy
    unless @product_cate.products.any?
      @product_cate.destroy
      @code = 'Success'
    end
    respond_to do |format|
      if @code
        format.html { redirect_to product_cates_url, notice: 'ProductCate was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to product_cates_url, notice: '删除失败,该分类已经绑定相关资料', status: 422 }
        format.json { render json: { error: '删除失败,该分类已经绑定相关资料' }, status: 422 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_cate
      @product_cate = Manage::ProductCate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_cate_params
      params.require(:product_cate).permit(:name)
    end
end
