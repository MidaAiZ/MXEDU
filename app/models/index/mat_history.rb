class Index::MatHistory < ApplicationRecord
   belongs_to :user,
			  class_name: 'Index::User',
			  foreign_key: :user_id,
			  optional: true
   belongs_to :material,
			  class_name: 'Index::Material',
			  foreign_key: :material_id

   default_scope { order(updated_at: :DESC) }

   def self.add u, m, ip
	   if u
		   create_u_his u, m
	   else
		   create_ip_his ip, m
	   end
   end

   private

   # 浏览记录
   # 一天新建一个浏览记录
   # 同一个用户或者IP每6小时可以重新计算一次浏览记录
   def self.create_u_his u, m
	   h = self.find_or_initialize_by(material_id: m.id, user_id: u.id)
	   if h.id
		 if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
		   h = self.new(material_id: m.id, user_id: u.id)
		   m.update readtimes: (material.readtimes + 1)
		 elsif (Time.now - h.updated_at > (Time.now - 6.hours.ago))
		   m.update readtimes: (m.readtimes + 1)
		 end
	   else
		   m.update readtimes: (m.readtimes + 1)
	   end
	   h.material_name = m.name
	   h.times += 1
	   h.save!
   end

   def self.create_ip_his ip, m
	   h = self.find_or_initialize_by(material_id: m.id, remote_ip: ip)
	   if h.id
		 if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
		   h = self.new(material_id: m.id, remote_ip: ip)
		   m.update readtimes: (m.readtimes + 1)
		 elsif (Time.now - h.updated_at > (Time.now - 6.hours.ago))
		   m.update readtimes: (m.readtimes + 1)
		 end
	   else
		   m.update readtimes: (m.readtimes + 1)
	   end
	   h.material_name = m.name
	   h.times += 1
	   h.save!
   end
end
