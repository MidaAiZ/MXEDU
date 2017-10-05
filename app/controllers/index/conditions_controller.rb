class Index::ConditionsController < ApplicationController
	def search_school
        cons = params.slice(:name)
        @schools = Manage::School.sort(cons)
		render :schools
	end

	def search_company
		cons = params.slice(:name)
		@companies = Manage::ProductCompany.sort(cons)
		render :companies
	end

	def search_product_cate
		cons = params.slice(:name)
		@cates = Manage::ProductCate.sort(cons)
		render :product_cates
	end

	def search_material_cate
        cons = params.slice(:name)
        @cates = Manage::MaterialCate.sort(cons)
		render :material_cates
	end

	def search_post_cate
		cons = params.slice(:name)
        @cates = Manage::PostCate.sort(cons)
		render :post_cates
	end
end
