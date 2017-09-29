class Index::PostComment < ApplicationRecord
	belongs_to :user,
			   class_name: 'Index::User',
			   foreign_key: :user_id

	belongs_to :post,
				class_name: 'Index::Post',
				foreign_key: :post_id

	has_many :thumbs, as: :resource,
			  class_name: 'Index::Thumb',
			  dependent: :destroy

    has_many :son_comments,
			  class_name: 'Index::PostSonComment',
			  foreign_key: :post_cmt_id,
			  dependent: :destroy

	default_scope -> { order(thumbs_count: :DESC).order(created_at: :DESC) }


	def _save user, post
		self.user = user
		self.post = post
		begin
			ApplicationRecord.transaction do # 出错将回滚
				self.save!
				post.update! comments_count: ((post.comments_count || 0) + 1)
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
		end
	end

	def has_thumb? uid, ip
		uid ? self.thumbs.find_by_user_id(uid) : self.thumbs.find_by_remote_ip(ip)
	end
end
