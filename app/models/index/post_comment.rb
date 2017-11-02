class Index::PostComment < ApplicationRecord
	belongs_to :user,
			   class_name: 'Index::User',
			   foreign_key: :user_id

	belongs_to :post, -> { with_all },
				class_name: 'Index::Post',
				foreign_key: :post_id

	has_many :thumbs, as: :resource,
			  class_name: 'Index::Thumb',
			  dependent: :destroy

    has_many :son_comments,
			  class_name: 'Index::PostSonComment',
			  foreign_key: :post_cmt_id,
			  dependent: :destroy

    has_many :msgs, as: :resource,
			 class_name: 'Index::PostMsg'


    validates :content, length: { minimum: 0, too_short: '内容不能为空', maximum: 5000, too_long: '评论内容最大长度为%{count}' }

	scope :hot, -> { order(thumbs_count: :DESC) }
	scope :with_all, -> { order(updated_at: :DESC) }
	default_scope -> { hot.order(updated_at: :DESC) }

	def _save user, post
		self.user = user
		self.post = post
		begin
			ApplicationRecord.transaction do # 出错将回滚
				self.save!
				post.update! comments_count: ((post.comments_count || 0) + 1)
				Index::PostMsg._create user, post, self.content, id
			end
		rescue
			return false
		end
		true
	end

	def _destroy
		ApplicationRecord.transaction do # 出错将回滚
			self.destroy!
			self.post.update! comments_count: (post.comments_count - 1)
			Index::PostMsg._delete user, post, id
		end
	end

	def has_thumb? u, ip
		u && u.id ? self.thumbs.find_by_user_id(u.id) : self.thumbs.find_by_remote_ip(ip)
	end

	def can_del? u
	    self.user_id == u.id || self.post.user_id == u.id
	end
end
