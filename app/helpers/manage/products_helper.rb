module Manage::ProductsHelper
	def get_cate cate
		case cate
		when 'liuxue'
			'留学'
		when 'yupei'
			'语培'
		when 'kaoyan'
			'考研'
		when 'jiakao'
			'驾校'
		when 'yule'
			'娱乐'
	    else
			'其它'
		end
	end
end
