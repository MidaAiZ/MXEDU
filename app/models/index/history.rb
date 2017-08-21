class Index::History < ApplicationRecord
	belongs_to :user,
			   class_name: 'Index::User',
			   foreign_key: :user_id
	belongs_to :product,
			   class_name: 'Index::Product',
			   foreign_key: :p_id

	def self.add uid, p
		h = self.find_or_create_by(p_id: p.id, user_id: uid)
		h.product_name = p.name
		h.updated_at = Time.now
		h.save!
	end
end
