class Manage::School < ApplicationRecord
	has_many :materials,
			 class_name: 'Index::Material',
 			 foreign_key: :school_id

	 validates :city, length: { minimum: 1, too_short: '城市不能为空', maximum: 16, too_long: '城市名最大长度为%{count}' }
	 validates :name, length: { minimum: 1, too_short: '学校名不能为空', maximum: 64, too_long: '学校名最大长度为%{count}' }
     validates :cate, length: { minimum: 1, too_short: '分类不能为空', maximum: 16, too_long: '分类名最大长度为%{count}'  }
end
