class Index::Product < ApplicationRecord
	mount_uploader :cover, ProductsCoverUploader # 封面上传

	# 用于上传头像时保存图片参数
	attr_accessor :x, :y, :width, :height, :rotate

	store_accessor :info, :company, :tag

	has_many :appoints,
			 class_name: 'Index::Appoint',
			 foreign_key: :product_id

	belongs_to :admin,
				class_name: 'Manage::Admin',
				foreign_key: :admin_id

	validates :name, length: { minimum: 1, maximum: 32 },
						 allow_blank: false
    validates :cate, length: { minimum: 1, maximum: 16 },
					  allow_blank: false

	validates :intro, length: { maximum: 128 }
	validates :details, length: { maximum: 10000 }

	# 筛选
	scope :sort,  ->(cate) { where(cate: cate) }
end
