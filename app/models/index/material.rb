class Index::Material < ApplicationRecord
	mount_uploader :cover, MaterialCoverUploader

	store_accessor :info, :intro, :details, :d_times, :need_login, :recommend

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
	validates :tag, length: { maximum: 32, too_long: '标签最大长度为%{count}' }
	validates :cate, length: { minimum: 1, too_short: '类型不能为空' }

	default_scope { where(is_deleted: false).order(readtimes: :DESC) }

	# 复杂条件筛选
	def self.sort(cons = {})
		_self = self
		_self = _self.where(cate_id: cons[:cate]) if cons[:cate]
		_self = _self.where(grade: cons[:grade]) if cons[:grade]
		_self = _self.where(school_id: cons[:school]) if cons[:school]
		_self = _self.where("index_materials.tag LIKE ?", cons[:tag] ) if cons[:tag]
		_self = _self.where("index_materials.name LIKE ?", cons[:name] ) if cons[:name]

		_self ||= self.all
	end

	def fake_readtimes
		(self.readtimes || 0)+ (self.id % 11 + 3) * 35
	end

	def fake_d_times
		(self.d_times || 0)+ (self.id % 11 + 3) * 17
	end
end
