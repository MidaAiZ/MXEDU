class Index::ProductsController < IndexController
  before_action :check_login
  before_action :set_index_product, only: [:show, :edit, :update, :destroy]

  # GET /index/products
  # GET /index/products.json
  def index
    count = params[:count] || 20
    page = params[:page] || 1
    cons = set_rec_cons params.slice(:name, :school, :company, :cate, :tag)
    nonpaged_products = Index::Product.sort(cons)
    @products = nonpaged_products.page(page).per(count).includes(:company)
    set_cdts
    set_title "校园产品"
  end

  # GET /index/products/1
  # GET /index/products/1.json
  def show
    if !@user && @product.need_login
      Cache.new[request.remote_ip + '_history'] = request.url
    else
        Index::History.add @user, @product, request.remote_ip
        @likes = Index::Product.sort({school: @product.school_id, cate: @product.cate_id}).where.not(id: @product.id).limit(5).includes(:cate)
        @user ||= Index::User.new
    end
    set_title @product.name
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index_product
      @product = Index::Product.with_del.find(params[:id])
      redirect_to "/product_404" and return if @product.is_deleted
    end

    def get_likes

    end

    def set_cdts
        s_id = @user.school_id if @user
        cons = Rails.cache.fetch("#{cache_key}_#{s_id}_cd", expires_in: 10.minutes) do
          {
            schools: s_id ? Manage::School.where(id: s_id) + (Manage::School.where.not(id: s_id)).limit(5) : Manage::School.limit(6),
            cates: Manage::ProductCate.limit(6),
            companies: Manage::ProductCompany.limit(6)
          }
        end
        @schools = cons[:schools]
        @cates = cons[:cates]
        @companies = cons[:companies]
    end

    def set_rec_cons cons
        cons[:school] = @user.school_id if @user && cons[:school].nil? # 院校资料推荐
        cons
    end
end
