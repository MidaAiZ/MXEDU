class Manage::ProductCompaniesController < ManageController
  before_action :require_login
  before_action :set_product_company, only: [:show, :edit, :update, :destroy]

  # GET /manage/product_companies
  # GET /manage/product_companies.json
  def index
    @product_companies = Manage::ProductCompany.all
  end

  # GET /manage/product_companies/1
  # GET /manage/product_companies/1.json
  def show
  end

  # GET /manage/product_companies/new
  def new
    @product_company = Manage::ProductCompany.new
  end

  # GET /manage/product_companies/1/edit
  def edit
  end

  # POST /manage/product_companies
  # POST /manage/product_companies.json
  def create
    @product_company = Manage::ProductCompany.new(product_company_params)

    respond_to do |format|
      if @product_company.save
        format.html { redirect_to @product_company, notice: 'ProductCompany was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @product_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/product_companies/1
  # PATCH/PUT /manage/product_companies/1.json
  def update
    respond_to do |format|
      if @product_company.update(product_company_params)
        format.html { redirect_to @product_company, notice: 'ProductCompany was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_company }
      else
        format.html { render :edit }
        format.json { render json: @product_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/product_companies/1
  # DELETE /manage/product_companies/1.json
  def destroy
    unless @product_company.products.any?
      @product_company.destroy
      @code = 'Success'
    end

    respond_to do |format|
      if @code
        format.html { redirect_to product_companies_url, notice: 'ProductCompany was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to product_companies_url, notice: '删除失败,该分类已经绑定相关资料', status: 422 }
        format.json { render json: { error: '删除失败,该分类已经绑定相关资料' }, status: 422 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_company
      @product_company = Manage::ProductCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_company_params
      params.require(:product_company).permit(:name, :cate)
    end
end
