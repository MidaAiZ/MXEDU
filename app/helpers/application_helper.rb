module ApplicationHelper
	def check_cur_ctrl(ctrl)
	  if params[:controller] == ctrl
		'nav-active'
	  else
		''
	  end
	end

	def check_cur_act(action)
	  if params[:action] == action
		'active'
	  else
		''
	  end
	end
end
