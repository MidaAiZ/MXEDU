class Index::Product < ApplicationRecord
	mount_uploader :cover, ProductsCoverUploader # 封面上传

	# 用于上传头像时保存图片参数
	attr_accessor :x, :y, :width, :height, :rotate

	store_accessor :info, :company, :tag, :recommend, :need_login

	has_many :appoints,
			 class_name: 'Index::Appoint',
			 foreign_key: :product_id

	belongs_to :admin,
				class_name: 'Manage::Admin',
				foreign_key: :admin_id

	validates :name, length: { minimum: 1, too_short: '产品名不能为空', maximum: 32, too_long: '产品名最大长度为%{count}' }
    validates :cate, length: { minimum: 1, too_short: '类型不能为空', maximum: 16, too_long: '类型名最大长度为%{count}'  },
					inclusion: %w(liuxue yupei kaoyan jiakao yule else)
	validates :company, length: { minimum: 1, too_short: '公司/机构不能为空', maximum: 128, too_long: '公司/机构名最大长度为%{count}' }
	validates :price, numericality: { greater_than_or_equal_to: 0 }, length: { minimum: 0, too_short: '原价不能为空' }
	validates :dis_price, numericality: { greater_than_or_equal_to: 0 }, length: { minimum: 0, too_short: '优惠价不能为空' }
	validates :recommend, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 0 }

	validates :intro, length: { maximum: 128, too_long: '简介最长为%{count}个字符' }
	validates :details, length: { minimum: 1, too_short: '详情不能为空', aximum: 10000, too_long: '详情最长为%{count}个字符' }

	default_scope { where(is_deleted: false).order(readtimes: :DESC) }

	# 筛选
	def self.sort(cate)
		if cate.nil?
			self.all
		elsif cate == 'else'
			self.where.not(cate: [:liuxue, :yupei, :jiakao, :kaoyan, :yule])
		else
			self.where(cate: cate)
		end
	end

	def fake_readtimes
		(self.readtimes || 0)+ (self.id % 11 + 3) * 21
	end

	def self.cates
		%w(yupei liuxue kaoyan jiakao yule else)
	end
end
