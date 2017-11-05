class Index::PostHistory < ApplicationRecord
   belongs_to :user,
              class_name: 'Index::User',
              foreign_key: :user_id,
              optional: true
   belongs_to :post, -> { with_all },
              class_name: 'Index::Post',
              foreign_key: :post_id

   default_scope { order(updated_at: :DESC) }

   # 浏览记录
   # 一天新建一个浏览记录
   # 同一个用户或者IP每6小时可以重新计算一次浏览记录
    def self.add post, ip, user = nil
       h = self.find_or_initialize_by(post_id: post.id, remote_ip: ip)
       if h.id
         if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
           h = self.new(post_id: post.id, remote_ip: ip)
         end
       end
       h.user = user if user
       h.times += 1
       h.save!
    end

   private

end
