class Index::Appoint < ApplicationRecord
	belongs_to :user,
			   class_name: 'Index::User',
			   foreign_key: :user_id

    belongs_to :product,
   		   class_name: 'Index::Product',
   		   foreign_key: :product_id

	validates :name, length: { minimum: 1, maximum: 32 },
						 allow_blank: false
    validates :time, length: { maximum: 32 },
					  allow_blank: true

    validates :phone,
			  format: { with: Validate::VALID_PHONE_REGEX },
			  allow_blank: true
    validates :content, length: { maximum: 1000 }
end
