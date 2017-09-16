class Manage::MaterialCate < ApplicationRecord
	has_many :materials,
			 counter_cache: true,
			 class_name: 'Index::Material',
			 foreign_key: :cate_id


    validates :name, uniqueness: { message: "该分类已经存在" }, length: { minimum: 1, too_short: '分类名不能为空', maximum: 10, too_long: '分类名最大长度为%{count}' }

	default_scope { order(materials_count: :DESC) }
end
