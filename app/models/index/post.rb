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

	has_many :thumbs, as: :resource,
			  class_name: 'Index::Thumb',
			  dependent: :destroy

	has_many :comments,
			 class_name: 'Index::PostComment',
			 foreign_key: :post_id,
			 dependent: :destroy

 	has_many :son_comments,
			 through: :comments,
			 source: :son_comments,
			 dependent: :destroy

	validates :name, length: { maximum: 32, too_long: '帖子名最大长度为%{count}' }
	validates :content, length: { maximum: 10000, too_long: '帖子内容最大长度为%{count}' }
	validates :state, inclusion: [0, 1, 2, 3] # 状态码,1代码正常, 2代表用户删除, 3代表后台删除, 保留0用于后期扩展

	scope :published, -> { rewhere(state: 1) }
	scope :deleted, -> { rewhere(state: 2) }
	scope :forbidden, -> { rewhere(state: 3) }
	scope :with_del, -> { (rewhere(state: [1, 2])) }
	scope :with_forbid, -> { (rewhere(state: [1, 2, 3])) }
	default_scope -> { published.order(updated_at: :DESC) }

	# 复杂条件筛选
	def self.sort(cons = {})
		_self = self
		_self = _self.where(cate_id: cons[:cate]) if cons[:cate]
		if cons[:content] && cons[:tag]
			_self = _self.where("index_posts.content LIKE ? OR index_posts.tag LIKE ?", "%#{cons[:content]}%", "%#{cons[:tag]}%")
		else
			_self = _self.where("index_posts.name LIKE ?", "%#{cons[:content]}%" ) if cons[:content]
			_self = _self.where("index_posts.tag LIKE ?", "%#{cons[:tag]}%" ) if cons[:tag]
		end
		_self = _self.where(school_id: cons[:school]) if cons[:school] && cons[:school] != 'NONE'

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

	def has_thumb? uid, ip
		uid ? self.thumbs.find_by_user_id(uid) : self.thumbs.find_by_remote_ip(ip)
	end
end
