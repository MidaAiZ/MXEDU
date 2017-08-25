class Manage::MainController < ManageController
    before_action :require_login
	before_action :check_super, except: :index

    def index
        @new_users = Index::User.all #where(created_at: Time.now.midnight..Time.now) if @admin.super?
    end

    def counts
       u_count = Index::User.count # 用户总数
	   p_count = Index::Product.count # 产品总数
	   a_count = Index::Appoint.count # 预约总数
	   v_count = Index::Product.sum("readtimes") # 总浏览量
       t_u_count = Index::History.where(created_at: Time.now.midnight..Time.now).count # 今日新增用户
       t_a_count = Index::History.where(created_at: Time.now.midnight..Time.now).count # 今日预约数
       t_v_count = Index::Appoint.where(updated_at: Time.now.midnight..Time.now).count # 今日浏览量

       render json: {
		  u_count: u_count,
		  p_count: p_count,
		  a_count: a_count,
		  v_count: v_count,
          t_u_count: t_u_count,
          t_a_count: t_a_count,
          t_v_count: t_v_count
		}
    end


end
