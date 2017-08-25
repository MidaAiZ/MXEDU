class Manage::MainController < ManageController
    before_action :require_login
	before_action :check_super, except: :index

    def index

    end

    def counts
       u_count = Index::User.count
	   p_count = Index::Product.count
	   a_count = Index::Appoint.count
	   v_count = Index::Product.sum("readtimes")

       render json: {
		  u_count: u_count,
		  p_count: p_count,
		  a_count: a_count,
		  v_count: v_count
		}
    end


end
