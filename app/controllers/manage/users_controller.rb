class Manage::UsersController < ManageController
	before_action :require_login
	before_action :set_user, only: [:show, :edit, :update]

	def index
		count = params[:count] || 20
		page = params[:page] || 1

	 	nonpaged_users = Index::User.all
		@users = nonpaged_users.page(page).per(count).includes(:school)
	end

	def show
		@histories = @user.histories.limit(20).includes(:product)
		@posts = @user.posts.limit(8)
	end

    def edit
		set_select_cache
    end

	def update
	  respond_to do |format|
		if @user.update(update_user_params)
		  format.html { redirect_to manage_user_path(@user), notice: 'User was successfully updated.' }
		  format.json { render :show, status: :ok }
		else
		  set_select_cache
		  format.html { render :edit }
		  format.json { render json: @user.errors, status: :unprocessable_entity }
		end
	  end
	end

	def posts
		@user = Index::User.find(params[:user_id])
		count = params[:count] || 10
		page = params[:page] || 1
		nonpaged_posts = @user.posts
		@posts = nonpaged_posts.page(page).per(count).includes(:cate, :school)
	    render(:_post_lists, layout: false) and return if params["dl"]
	end

	private

    def update_user_params
      params.require(:index_user).permit(:name, :sex, :school_id, :major, :grade)
    end

	def set_user
		@user = Index::User.find params[:id]
	end

	def set_select_cache
		@schools = Manage::School.where(id: @user.school_id) + Manage::School.where.not(id: @user.school_id).limit(7)
	end
end
