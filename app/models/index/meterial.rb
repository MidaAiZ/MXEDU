class Index::Meterial < ApplicationRecord
	mount_uploader :attach, MarerialAttachUploader
	store_accessor :info, :d_times, :r_times, :need_login

	belongs_to :admin,
				class_name: 'Manage::Admin',
				foreign_key: 'admin_id'

	belongs_to :shool,
				class_name: 'Manage:School',
				foreign_key: :school_id

	validates :name, length: { minimum: 1, too_short: '资料名不能为空', maximum: 64, too_long: '资料名最大长度为%{count}' }
    validates :cate, length: { minimum: 1, too_short: '类型不能为空', maximum: 16, too_long: '类型名最大长度为%{count}'  }
	validates :tag, length: { maximum: 32, too_long: '标签最大长度为%{count}' }
end
