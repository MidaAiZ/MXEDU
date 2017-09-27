class Manage::PostCate < ApplicationRecord
	has_many :posts, -> { with_del },
			 counter_cache: true,
			 class_name: 'Index::Post',
			 foreign_key: :cate_id

	validates :name, uniqueness: { message: "该分类已经存在" }, length: { minimum: 1, too_short: '分类名不能为空', maximum: 10, too_long: '分类名最大长度为%{count}' }

	default_scope { order(posts_count: :DESC) }

	# 复杂条件筛选
	def self.sort(cons = {})
		_self = self
		_self = _self.where("manage_post_cates.name LIKE ?", "%#{cons[:name]}%").limit(10) if cons[:name]

		_self ||= self.all
	end
end
