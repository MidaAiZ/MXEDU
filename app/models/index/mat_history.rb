class Index::MatHistory < ApplicationRecord
   belongs_to :user,
			  class_name: 'Index::User',
			  foreign_key: :user_id,
			  optional: true
   belongs_to :material, -> { with_del },
			  class_name: 'Index::Material',
			  foreign_key: :material_id

   default_scope { order(updated_at: :DESC) }

   # 浏览记录
   # 一天新建一个浏览记录
   # 同一个用户或者IP每6小时可以重新计算一次浏览记录
   def self.add mat, ip, user
       h = self.find_or_initialize_by(material_id: mat.id, remote_ip: ip)
       if h.id
         if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
           h = self.new(material_id: mat.id, remote_ip: ip)
         end
       end
       mat.update readtimes: (mat.readtimes + 1)
       h.user = user if user
       h.material_name = mat.name
       h.times += 1
       h.save!
   end

   private
end
