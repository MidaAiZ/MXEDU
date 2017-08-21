class Index::Product < ApplicationRecord
	validates :name, length: { minimum: 1, maximum: 32 },
						 allow_blank: false
    validates :cate, length: { minimum: 1, maximum: 16 },
					  allow_blank: false

	validates :intro, length: { maximum: 128 }
	validates :details, length: { maximum: 10000 }

	# 筛选
	scope :sort,  ->(cate) { where(cate: cate) }
end
