module ApplicationHelper
	def check_cur_ctrl(ctrl)
	  if ctrl.include? params[:controller]
		'nav-active'
	  else
		''
	  end
	end

	def check_cur_act(action)
	  if action.include? params[:action]
		'active'
	  else
		''
	  end
	end
end
