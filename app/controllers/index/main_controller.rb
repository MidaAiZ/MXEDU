class Index::MainController < IndexController
	def index
		@liuxue = Index::Product.sort(:liuxue).limit(6) || Index::Product.none
		@yupei = Index::Product.sort(:yupei).limit(6) || Index::Product.none
		@kaoyan = Index::Product.sort(:kaoyan).limit(6) || Index::Product.none
		@jiakao = Index::Product.sort(:jiakao).limit(6) || Index::Product.none
	end
end
