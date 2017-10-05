class Manage::PostNotice < ApplicationRecord
	belongs_to :school,
			   class_name: 'Manage::School',
			   foreign_key: :school_id,
			   optional: true

    belongs_to :admin, -> { with_del },
			   class_name: 'Manage::Admin',
			   foreign_key: :admin_id

	default_scope { where(is_deleted: false).order(updated_at: :DESC) }
   	scope :deleted, -> { unscope(where: :is_deleted).where(is_deleted: true) }
   	scope :with_del, -> { unscope(where: :is_deleted) }

	validates :title, length: { minimum: 1, too_short: "标题不能为空", maximum: 32, too_long: '标题最大长度为%{count}' }
	validates :cate, length: { maximum: 8, too_long: '类型最大长度为%{count}' }
	validates :content, length: { minimum: 1, too_short: '内容不能为空', maximum: 10000, too_long: '内容最大长度为%{count}' }

	def self.cates
		%w(公告 规章 通知)
	end

	def read!
		self.update! readtimes: (self.readtimes + 1)
	end

	def is_deleted?
		self.is_deleted
	end

	# 复杂条件筛选
	def self.sort(cons = {})
		_self = self
		_self = _self.where(school_id: cons[:school]) if cons[:school] && cons[:school] != 'NONE'
		_self = _self.where("index_post_notices.name LIKE ?", "%#{cons[:name]}%" ) if cons[:name]

		_self ||= self.all
	end

end
