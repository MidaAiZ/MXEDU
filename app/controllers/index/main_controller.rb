class Index::MainController < IndexController
	before_action :check_login
	def index
		school = @user.school_id if @user
		@products = Rails.cache.fetch("#{cache_key}_p_s_#{school}", expires_in: 10.minutes) do
		  cates = Manage::ProductCate.limit(5)
		  info = {}
		  cates.each do |c|
			  info[c.name] = []
			  info[c.name].push c.id
			  info[c.name].push Index::Product.sort({school: school, cate: c.id}).limit(6) || Index::Product.none
		  end
		  info
	    end

		@materials = Rails.cache.fetch("#{cache_key}_m_s_#{school}", expires_in: 10.minutes) do
	      Index::Material.sort({school: school}).limit(6).includes(:school, :cate)
	    end

		@carousels = Rails.cache.fetch("#{cache_key}", expires_in: 2.minutes) do
			Manage::Carousel.where(show: true).order(index: :desc)
		end
		set_title '首页'
	end
end
