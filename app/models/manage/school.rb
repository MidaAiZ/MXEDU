class Manage::School < ApplicationRecord
	has_many :students,
			 counter_cache: true,
			 class_name: 'Index::User',
			 foreign_key: :school_id

	has_many :materials,
			 counter_cache: true,
			 class_name: 'Index::Material',
 			 foreign_key: :school_id

	has_many :products,
			 counter_cache: true,
			 class_name: 'Index::Product',
	 		 foreign_key: :school_id

	 validates :city, length: { minimum: 1, too_short: '城市不能为空', maximum: 16, too_long: '城市名最大长度为%{count}' }
	 validates :name, uniqueness: { message: "该学校已经存在" }, length: { minimum: 1, too_short: '学校名不能为空', maximum: 64, too_long: '学校名最大长度为%{count}' }

	 default_scope { where(is_deleted: false).order(users_count: :DESC) }
end
