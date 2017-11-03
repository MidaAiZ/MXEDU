class Manage::MaterialFile < ApplicationRecord
	mount_uploader :file, MaterialAttachUploader

	belongs_to :material, -> { with_del },
			 class_name: 'Index::Material',
			 foreign_key: :material_id

	validates :name, length: {  maximum: 128, too_long: '文件名最大长度为%{count}' }
	validates :f_type, length: {  maximum: 64, too_long: '文件类型最大长度为%{count}' }
	# default_scope { }

	def dload_path
		"/materials/download/#{self.id}/#{self.name}"
	end

	def manage_dload_path
		"/manage/materials/download/#{self.id}/#{self.name}"
	end

	def self.upload prms, m
		file = self.new(file: prms[:file], name: prms[:file].original_filename, f_type: prms[:file].content_type, size: prms[:filesize])
		file.material = m
		file
	end
end
