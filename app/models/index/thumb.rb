class Index::Thumb < ApplicationRecord
	belongs_to :user,
				class_name: 'Index::User',
				foreign_key: :user_id,
				optional: true

	belongs_to :resource, polymorphic: true

	def self.thumb_up u, rsc, type = 'user'
		rsc.thumbs_count = (rsc.thumbs_count || 0) + 1

		t = if type == 'user'
			  rsc.thumbs.find_by_user_id(u)
		    else
			  rsc.thumbs.find_by_remote_ip(u)
			end

		return false if t
		ApplicationRecord.transaction do # 出错将回滚
			_self = self.new
			type == 'user' ? (_self.user = u) : (_self.remote_ip = u)
			_self.resource = rsc
			_self.save!
			rsc.save!
			if (u)
				Index::PostMsg._create u, rsc, '赞了我', _self.id
			end
		end
	end


	def cancel
	  begin
		ApplicationRecord.transaction do # 出错将回滚
		  t_c = resource.thumbs_count - 1
		  t_c = 0 if t_c < 0 # 防止极端情况下因数据库不同步导致点赞数<0
		  resource.update! thumbs_count: t_c
		  destroy!
		  if user
			  Index::PostMsg._delete(user, resource, id)
		  end
	    end
	  rescue => e
		puts e
		return false
	  end
	end
end
