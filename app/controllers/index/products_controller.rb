class Index::ProductsController < ApplicationController
  before_action :set_index_product, only: [:show, :edit, :update, :destroy]

  # GET /index/products
  # GET /index/products.json
  def index
    @index_products = Index::Product.all
  end

  # GET /index/products/1
  # GET /index/products/1.json
  def show
  end

  # GET /index/products/new
  def new
    @index_product = Index::Product.new
  end

  # GET /index/products/1/edit
  def edit
  end

  # POST /index/products
  # POST /index/products.json
  def create
    @index_product = Index::Product.new(index_product_params)

    respond_to do |format|
      if @index_product.save
        format.html { redirect_to @index_product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @index_product }
      else
        format.html { render :new }
        format.json { render json: @index_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /index/products/1
  # PATCH/PUT /index/products/1.json
  def update
    respond_to do |format|
      if @index_product.update(index_product_params)
        format.html { redirect_to @index_product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @index_product }
      else
        format.html { render :edit }
        format.json { render json: @index_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /index/products/1
  # DELETE /index/products/1.json
  def destroy
    @index_product.destroy
    respond_to do |format|
      format.html { redirect_to index_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_product
      @index_product = Index::Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_product_params
      params.require(:index_product).permit(:name, :price, :intro, :info)
    end
end
