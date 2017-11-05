 class Index::History < ApplicationRecord
	belongs_to :user,
			   class_name: 'Index::User',
			   foreign_key: :user_id,
			   optional: true
	belongs_to :product, -> { with_del },
			   class_name: 'Index::Product',
			   foreign_key: :p_id

	default_scope { order('index_histories.updated_at DESC') }

    # 浏览记录
    # 一天新建一个浏览记录
    # 同一个用户或者IP每6小时可以重新计算一次浏览记录
	def self.add prod, ip, user
        h = self.find_or_initialize_by(p_id: prod.id, remote_ip: ip)
		if h.id
		  if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
  			h = self.new(p_id: prod.id, remote_ip: ip)
  		  end
		end
        prod.update readtimes: (prod.readtimes + 1)
		h.product_name = prod.name
        h.user = user if user
		h.times += 1
		h.save!
	end

	private


	def self.create_ip_his ip, p

	end
end
