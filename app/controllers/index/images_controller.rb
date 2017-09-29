class Index::ImagesController < IndexController
  before_action :require_login
  before_action :set_image, only: [:show, :destroy]

  def index
    @nonpaged_images = @user.images.order(id: :desc)
    @images = @nonpaged_images.page(params[:page]).per(15)

    respond_to do |format|
      format.json { render :index }
      format.html { render :index, formats: [:json] }
    end
  end

  def create
    @image = Index::Image.new(link: params[:file])
	@image.user = @user
    respond_to do |format|
      if @image.save
        # 只返回json
        format.json { render :show }
        format.html { render :show, formats: [:json] }
        # :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder]}
      else
        format.json { render nothing: true }
        format.html { render nothing: true }
      end
    end
  end

  def destroy
    @image.destroy
    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to :index }
    end
  end

  def show
    respond_to do |format|
      format.json { render :show }
      format.html { render :show, formats: [:json] }
    end
  end

  private

  def index_image_params
    # params.require(:image).permit(:link)
  end

  def set_image
    @image = Index::Image.find(params[:id])
  end
end
