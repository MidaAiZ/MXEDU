class Index::Post < ApplicationRecord
	belongs_to :user,
			   class_name: "Index::User",
			   foreign_key: :user_id

    belongs_to :school,
               class_name: 'Manage::School',
               foreign_key: :school_id

	belongs_to :cate,
				class_name: 'Manage::PostCate',
				foreign_key: :cate_id,
				optional: true

	validates :name, length: { minimum: 1, too_short: '帖子名不能为空', maximum: 32, too_long: '帖子名最大长度为%{count}' }
	validates :state, inclusion: [0, 1, 2, 3] # 状态码,1代码正常, 2代表用户删除, 3代表后台删除, 保留0用于后期扩展

	scope :published, -> { rewhere(state: 1) }
	scope :deleted, -> { rewhere(state: 2) }
	scope :forbidden, -> { rewhere(state: 3) }
	scope :with_del, -> { (rewhere(state: [1, 2])) }
	scope :with_forbid, -> { (rewhere(state: [1, 2, 3])) }
	default_scope -> { published.order(id: :DESC) }

	# 复杂条件筛选
	def self.sort(cons = {})
		_self = self
		_self = _self.where(cate_id: cons[:cate]) if cons[:cate]
		_self = _self.where(school_id: cons[:school]) if cons[:school] && cons[:school] != 'NONE'
		if cons[:name]
			_self = _self.where("index_posts.name LIKE ?", "%#{cons[:name]}%")
		end

		_self ||= self.all
	end

	def is_deleted?
		self.state == 2
	end

	def is_forbidden?
		self.state == 3
	end

	def del!
		self.update! state: 2
	end

	def forbid!
		self.update! state: 3
	end
end
