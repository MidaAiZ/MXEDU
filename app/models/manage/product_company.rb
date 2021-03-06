class Manage::ProductCompany < ApplicationRecord
	has_many :products, -> { with_del },
			 counter_cache: true,
			 class_name: 'Index::Product',
			 foreign_key: :company_id

	validates :name, uniqueness: { message: "品牌名已经存在" }, length: { minimum: 1, too_short: '品牌名不能为空', maximum: 16, too_long: '品牌名最大长度为%{count}' }
	validates :cate, length: { maximum: 16, too_long: '类型描述最大长度为%{count}' }

	default_scope { order(products_count: :DESC) }

	# 复杂条件筛选
	def self.sort(cons = {})
		_self = self
		_self = _self.where("manage_product_companies.name LIKE ?", "%#{cons[:name]}%").limit(10) if cons[:name]

		_self ||= self.all
	end

end
