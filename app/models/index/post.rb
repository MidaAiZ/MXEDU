class Index::Post < ApplicationRecord
	belongs_to :user,
			   class_name: "Index::User",
			   foreign_key: :user_id

    belongs_to :school,
               class_name: 'Manage::School',
               foreign_key: :school_id,
			   optional: true

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

	has_many :msgs, as: :resource,
			  class_name: 'Index::PostMsg'

	validates :name, length: { maximum: 32, too_long: '帖子名最大长度为%{count}' }
	validates :content, length: { minimum: 0, too_short: '内容不能为空', maximum: 100000, too_long: '帖子内容最大长度为%{count}' }
	validates :state, inclusion: [0, 1, 2, 3, 4] # 状态码,1代码正常, 2代表用户删除, 3代表后台删除, 4代表置顶, 保留0用于后期扩展

	scope :published, -> { rewhere(state: self.publish_state) }
	scope :deleted, -> { rewhere(state: self.del_state) }
	scope :forbidden, -> { rewhere(state: self.forbid_state) }
	scope :with_del, -> { unscope(where: :state).where.not(state: self.forbid_state) }
	scope :with_forbid, -> { unscope(where: :state) }
	scope :with_all, -> { unscope(where: :state) }
	scope :hot, -> { reorder(updated_at: :DESC) } # 热门排序
	scope :top, -> { rewhere(state: self.top_state) } #置顶贴
	scope :state_ok, -> { rewhere(state: [self.publish_state, self.top_state]) }
	default_scope -> { state_ok.order(id: :DESC) }

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

	def is_published?
		self.state == publish_state
	end

	def is_deleted?
		self.state == del_state
	end

	def is_forbidden?
		self.state == forbid_state
	end

	def is_top?
		self.state == top_state
	end

	def publish!
		self.record_timestamps = false
		self.update! state: publish_state
	end

	def read!
		self.record_timestamps = false
		self.update! readtimes: ((self.readtimes || 0) + 1)
	end

	def state_ok?
		self.state.in? [publish_state, top_state]
	end

	def state_bad?
		self.state.in? [del_state, forbid_state]
	end

	def del!
		self.update! state: del_state
	end

	def forbid!
		self.update! state: forbid_state
	end

	def on_top!
		self.update! state: top_state
	end

	def off_top!
		self.update! state: publish_state
	end

	def has_thumb? u, ip
		u && u.id ? self.thumbs.find_by_user_id(u.id) : self.thumbs.find_by_remote_ip(ip)
	end

	def publish_state
		1
	end

	def del_state
		2
	end

	def forbid_state
		3
	end

	def top_state
		4
	end

	def self.publish_state
		1
	end

	def self.del_state
		2
	end

	def self.forbid_state
		3
	end

	def self.top_state
		4
	end

	# 消息提示
	def msg_cache

	end

end
