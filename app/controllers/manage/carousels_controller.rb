class Manage::CarouselsController <  ManageController
  before_action :require_login
  before_action :set_manage_carousel, only: [:edit, :update, :unshow, :reshow, :destroy, :set_location]

  # GET /manage/carousels
  # GET /manage/carousels.json
  def index
    @carousels = Manage::Carousel.where(show: true).order(index: :desc)
    @carousel = Manage::Carousel.new
  end

  # GET /manage/carousels/1
  # GET /manage/carousels/1.json
  def show
  end

  # GET /manage/carousels/new
  def new
    @carousel = Manage::Carousel.new
  end

  # GET /manage/carousels/1/edit
  def edit
  end

  # POST /manage/carousels
  # POST /manage/carousels.json
  def create
      @carousel = Manage::Carousel.new(manage_carousel_params)
      @carousel.index = Manage::Carousel.where(show: true).length + 1

      respond_to do |format|
        if @carousel.save
          format.html { redirect_to manage_carousel_path(@carousel) }
          format.json { render json: { target: manage_carousels_path } }
        else
          format.html { redirect_to new_manage_carousel_path }
          format.json { render json: @admin.errors }
        end
      end
  end

  # PATCH/PUT /manage/carousels/1
  # PATCH/PUT /manage/carousels/1.json
  def update
      respond_to do |format|
        old_img = @carousel.image
        if @carousel.update(manage_carousel_params)
          old_img.remove! if old_img && old_img != @carousel.image
          format.json { render json: { target: manage_carousels_path } }
          format.html { redirect_to manage_carousels_path }
        else
          format.html { head :no_content }
          format.json { render json: @admin.errors }
        end
      end
  end

  def history
    @nonpaged_carousels = Manage::Carousel.where(show: false).order(updated_at: :desc)
    @carousels = @nonpaged_carousels.page(params[:page]).per(12)
    if @carousels.length == 0 && params[:page] && params[:page].to_i > 1
      @carousels = @nonpaged_carousels.page((params[:page].to_i - 1 ).to_s).per(12)
    end
  end

  def unshow
    index = @carousel.index
    if @carousel.update(show: false, index: nil)
       Manage::Carousel.where("index > ? AND show = ?", index, true ).each do |c|
         c.update(index: c.index - 1)
       end
    end
    redirect_to manage_carousels_path
  end

  def reshow
      @carousel.index = Manage::Carousel.where(show: true).length + 1
      @carousel.show = true
      @carousel.save
      redirect_to manage_carousels_path
  end

  # DELETE /manage/carousels/1
  # DELETE /manage/carousels/1.json
  def destroy
    @carousel.destroy
    redirect_to history_manage_carousels_path + "?page=" + (params[:page] || "1")
  end

  def set_location
      change_location
      respond_to do |format|
        format.html { redirect_to manage_carousels_path }
        format.json { render json: { target: manage_carousels_path } }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_carousel
      @carousel = Manage::Carousel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manage_carousel_params
      params.require(:manage_carousel).permit(:image, :link)
    end

    def change_location
        if params[:lct] == 'advance'
          if @pre_carousel = Manage::Carousel.where("index > ? AND show = ?", @carousel.index, true ).order(index: :asc)[0]
            index = @carousel.index
            @pre_carousel.update(index: index )
            @carousel.update(index: index + 1 )
          end
        elsif params[:lct] == 'back'
          if @next_carousel = Manage::Carousel.where("index < ? AND show = ?", @carousel.index, true ).order(index: :desc)[0]
            index = @carousel.index
            @next_carousel.update(index: index )
            @carousel.update(index: index - 1 )
          end
        end
    end

end
