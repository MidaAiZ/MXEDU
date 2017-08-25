class Index::MainController < IndexController
	def index
		@liuxue = Index::Product.sort(:liuxue) || Index::Product.none
		@yupei = Index::Product.sort(:yupei) || Index::Product.none
		@kaoyan = Index::Product.sort(:kaoyan) || Index::Product.none
		@jiakao = Index::Product.sort(:jiakao) || Index::Product.none
	end
end
