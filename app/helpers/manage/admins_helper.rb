module Manage::AdminsHelper
	def translate_role role
		case role
		when 'super'
			'超级管理员'
		else
			'管理员'
		end
	end
end
