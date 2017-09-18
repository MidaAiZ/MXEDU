class Index::Material < ApplicationRecord
	mount_uploader :cover, MaterialCoverUploader

	store_accessor :info, :intro, :details, :need_login, :recommend

	belongs_to :admin, -> { with_del },
				class_name: 'Manage::Admin',
				foreign_key: 'admin_id'

	belongs_to :school,
	 			counter_cache: true,
				class_name: 'Manage::School',
				foreign_key: :school_id,
				optional: true

	belongs_to :cate,
				counter_cache: true,
				class_name: 'Manage::MaterialCate',
				foreign_key: :cate_id,
				optional: true

	has_many :files,
			  class_name: 'Manage::MaterialFile',
			  foreign_key: :material_id

	validates :name, length: { minimum: 1, too_short: '资料名不能为空', maximum: 64, too_long: '资料名最大长度为%{count}' }
	validates :tag, length: { maximum: 15, too_long: '标签最大长度为%{count}' }
	validates :cate, length: { minimum: 1, too_short: '类型不能为空' }

	default_scope { where(is_deleted: false).order(readtimes: :DESC) }
	scope :deleted, -> { unscope(where: :is_deleted).where(is_deleted: true) }
	scope :with_del, -> { unscope(where: :is_deleted) }

	# 复杂条件筛选
	def self.sort(cons = {})
		_self = self
		_self = _self.where(cate_id: cons[:cate]) if cons[:cate]
		_self = _self.where(grade: cons[:grade]) if cons[:grade]
		_self = _self.where(school_id: cons[:school]) if cons[:school] && cons[:school] != 'NONE'
		if cons[:name] && cons[:tag]
			_self = _self.where("index_materials.name LIKE ? OR index_materials.tag LIKE ?", "%#{cons[:name]}%", "%#{cons[:tag]}%")
		else
			_self = _self.where("index_materials.name LIKE ?", "%#{cons[:name]}%" ) if cons[:name]
			_self = _self.where("index_materials.tag LIKE ?", "%#{cons[:tag]}%" ) if cons[:tag]
		end
		_self ||= self.all
	end

	def fake_readtimes
		(self.readtimes)+ (self.id % 11 + 3) * 35
	end

	def fake_d_times
		(self.dload_count)+ (self.id % 11 + 3) * 21
	end
end
