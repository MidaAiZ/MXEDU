class Index::MainController < IndexController
	def index
		@products = Rails.cache.fetch("#{cache_key}", expires_in: 10.minutes) do
	      {
			  liuxue: Index::Product.sort(:liuxue).limit(6) || Index::Product.none,
			  yupei: Index::Product.sort(:yupei).limit(6) || Index::Product.none,
			  kaoyan: Index::Product.sort(:kaoyan).limit(6) || Index::Product.none,
			  jiakao: Index::Product.sort(:jiakao).limit(6) || Index::Product.none,
			  yule: Index::Product.sort(:yule).limit(6) || Index::Product.none
		   }
	    end

		@carousels = #Rails.cache.fetch("#{cache_key}", expires_in: 2.minutes) do
			Manage::Carousel.where(show: true).order(index: :desc)
		# end
	end
end
