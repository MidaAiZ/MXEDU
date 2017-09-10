class Index::Material < ApplicationRecord
	mount_uploader :cover, MaterialCoverUploader

	store_accessor :info, :intro, :details, :d_times, :need_login, :recommend, :grade

	belongs_to :admin,
				class_name: 'Manage::Admin',
				foreign_key: 'admin_id'

	belongs_to :school,
				class_name: 'Manage::School',
				foreign_key: :school_id,
				optional: true

	belongs_to :cate,
				class_name: 'Manage::MaterialCate',
				foreign_key: :cate_id,
				optional: true

	has_many :files,
			  class_name: 'Manage::MaterialFile',
			  foreign_key: :material_id

	validates :name, length: { minimum: 1, too_short: '资料名不能为空', maximum: 64, too_long: '资料名最大长度为%{count}' }
    validates :cate_id, length: { minimum: 1, too_short: '类型不能为空', maximum: 16, too_long: '类型名最大长度为%{count}'  }
	validates :tag, length: { maximum: 32, too_long: '标签最大长度为%{count}' }

	default_scope { where(is_deleted: false).order(readtimes: :DESC) }

	# 筛选
	def self.sort(cate)
		if cate.nil?
			self.all
		else
			self.where(cate: cate)
		end
	end
end
