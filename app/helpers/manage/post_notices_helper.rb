module Manage::PostNoticesHelper
	def get_notice_label type
		case type
		when '通知'
			'text-success'
		when '公告'
			'text-info'
		when '规章'
			'text-notice'
		else
			'text-primary'
		end
	end
end
