class Index::ProductsController < IndexController

  before_action :set_index_product, only: [:show, :edit, :update, :destroy]

  # GET /index/products
  # GET /index/products.json
  def index
    @products = Index::Product.sort(params[:cate])
  end

  # GET /index/products/1
  # GET /index/products/1.json
  def show
    if session[:user_id] && @product
       Index::History.add session[:user_id], @product
    end
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

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/products/1
  # PATCH/PUT /index/products/1.json
  def update
    respond_to do |format|
      if @product.update(index_product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /index/products/1
  # DELETE /index/products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to index_products_url, notice: 'Product was successfully destroyed.' }
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
      params.require(:product).permit(:name, :cate, :price, :intro, :details)
    end
end
