class Index::ProductsController < IndexController
  before_action :check_login
  before_action :set_index_product, only: [:show, :edit, :update, :destroy]

  # GET /index/products
  # GET /index/products.json
  def index
    count = params[:count] || 20
    page = params[:page] || 1

    nonpaged_products = Index::Product.sort(params[:type])
    @products = nonpaged_products.page(page).per(count)
  end

  # GET /index/products/1
  # GET /index/products/1.json
  def show
    if @user && @product
       Index::History.add session[:user_id], @product
       @likes = Index::Product.sort(@product.cate).where.not(id: @product.id).limit(5)
    end
    unless @user
      Cache.new[request.remote_ip + '_history'] = request.url
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

    def get_likes

    end
end
