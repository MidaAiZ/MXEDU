module Manage::PostNoticesHelper
	def get_notice_label type
		case type
		when '通知'
			'label-success'
		when '公告'
			'label-info'
		when '规章'
			'label-danger'
		else
			'label-primary'
		end
	end
end
