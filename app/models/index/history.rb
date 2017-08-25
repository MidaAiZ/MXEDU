class Index::History < ApplicationRecord
	belongs_to :user,
			   class_name: 'Index::User',
			   foreign_key: :user_id
	belongs_to :product,
			   class_name: 'Index::Product',
			   foreign_key: :p_id

	def self.add uid, p
		h = self.find_or_initialize_by(p_id: p.id, user_id: uid)
		if h.id
		  if (Time.now - h.updated_at > (Time.now - Time.now.midnight))
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
