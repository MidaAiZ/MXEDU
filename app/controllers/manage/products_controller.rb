class Manage::ProductsController < ManageController
  before_action :require_login
  before_action :set_index_product, only: [:show, :edit, :update, :destroy]

  # GET /index/products
  # GET /index/products.json
  def index
      count = params[:count] || 20
      page = params[:page] || 1
      nonpaged_products = Index::Product.sort(params[:type])
      @products = nonpaged_products.page(page).per(count).includes(:admin)
  end

  # GET /index/products/1
  # GET /index/products/1.json
  def show
    @t_a_count = @product.appoints.where(created_at: Time.now.midnight..Time.now).count # 今日预约数
    @t_v_count = Index::History.where(p_id: @product.id, updated_at: Time.now.midnight..Time.now).count # 今日浏览量
  end

  # GET /index/products/new
  def new
    @product = Index::Product.new
  end

  # GET /index/products/1/edit
  def edit
  end

  # POST /index/products
  # POST /index/products.json
  def create
    @product = Index::Product.new(index_product_params)
    @product.admin = @admin
    respond_to do |format|
      if @product.save
        format.html { render html: manage_product_path(@product) }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/products/1
  # PATCH/PUT /index/products/1.json
  def update
    respond_to do |format|
      if @product.update(index_product_params)
        format.html { render html: manage_product_path(@product) }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /index/products/1
  # DELETE /index/products/1.json
  def destroy
    @product.update is_deleted: true
    puts @product.errors
    respond_to do |format|
      format.html { redirect_to manage_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_product
      @product = Index::Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_product_params
      params.require(:product).permit(:name, :cate, :price, :dis_price, :intro, :details, :company, :cover, :recommend, :tags, :need_login?)
    end
end
