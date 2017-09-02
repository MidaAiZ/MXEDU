class Index::History < ApplicationRecord
	belongs_to :user,
			   class_name: 'Index::User',
			   foreign_key: :user_id,
			   optional: true
	belongs_to :product,
			   class_name: 'Index::Product',
			   foreign_key: :p_id

	default_scope { order('index_histories.updated_at DESC') }

	def self.add u, p, ip
		if u
			create_u_his u, p
		else
			create_ip_his ip, p
		end
	end

	private

	# 浏览记录
	# 一天新建一个浏览记录
	# 同一个用户或者IP每6小时可以重新计算一次浏览记录
	def self.create_u_his u, p
		h = self.find_or_initialize_by(p_id: p.id, user_id: u.id)
		if h.id
		  if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
			h = self.new(p_id: p.id, user_id: u.id)
			p.update readtimes: (p.readtimes + 1)
		  elsif (Time.now - h.updated_at > (Time.now - 6.hours.ago))
			p.update readtimes: (p.readtimes + 1)
		  end
		  h.updated_at = Time.now
		else
			p.update readtimes: (p.readtimes + 1)
		end
		h.product_name = p.name
		h.times += 1
		h.save!
	end

	def self.create_ip_his ip, p
		h = self.find_or_initialize_by(p_id: p.id, remote_ip: ip)
		if h.id
		  if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
  			h = self.new(p_id: p.id, remote_ip: ip)
  			p.update readtimes: (p.readtimes + 1)
  		  elsif (Time.now - h.updated_at > (Time.now - 6.hours.ago))
  			p.update readtimes: (p.readtimes + 1)
  		  end
  		  h.updated_at = Time.now
		else
			p.update readtimes: (p.readtimes + 1)
		end
		h.product_name = p.name
		h.times += 1
		h.save!
	end
end
