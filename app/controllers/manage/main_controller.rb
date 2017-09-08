class Manage::MainController < ManageController
    before_action :require_login
	before_action :check_super, except: :index

    def index
        @new_users = Index::User.new_user if @admin.super?
    end

    def counts
       info = Rails.cache.fetch("#{cache_key}", expires_in: 5.minutes) do
          {
             u_count: Index::User.count, # 用户总数
      	     p_count: Index::Product.count, # 产品总数
    	     a_count: Index::Appoint.count, # 预约总数
    	     v_count: Index::Product.sum("readtimes"), # 总浏览量
             t_u_count: Index::History.where(created_at: Time.now.midnight..Time.now).count, # 今日新增用户
             t_a_count: Index::Appoint.where(created_at: Time.now.midnight..Time.now).count, # 今日预约数
             t_v_count: Index::History.where(updated_at: Time.now.midnight..Time.now).sum(:times) # 今日浏览量
          }
       end

       render json: {
		  u_count: info[:u_count],
		  p_count: info[:p_count],
		  a_count: info[:a_count],
		  v_count: info[:v_count],
          t_u_count: info[:t_u_count],
          t_a_count: info[:t_a_count],
          t_v_count: info[:t_v_count]
		}
    end

    def products_count
        info = Rails.cache.fetch("#{cache_key}", expires_in: 10.minutes) do
           {
             yp_count: Index::Product.sort(:yupei).count, # 语培总数
             lx_count: Index::Product.sort(:liuxue).count, # 留学总数
     	     jk_count: Index::Product.sort(:jiakao).count, # 驾考总数
     	     ky_count: Index::Product.sort(:kaoyan).count, # 考研总数
             yl_count: Index::Product.sort(:yule).count, # 娱乐总数
             qt_count: Index::Product.sort(:else).count # 其它总数
           }
        end

        render json: {
 		  yp_count: info[:yp_count],
 		  lx_count: info[:lx_count],
 		  jk_count: info[:jk_count],
 		  ky_count: info[:ky_count],
          yl_count: info[:yl_count],
          qt_count: info[:qt_count]
 		}
    end

    def viewers_count

        info = Rails.cache.fetch("#{cache_key}", expires_in: 6.hours) do
            set_v_info
        end
        
        v_0_count = Rails.cache.fetch("#{cache_key}_v_0", expires_in: 1.minutes) do
            Index::History.where(updated_at: Time.now..Time.now.midnight).sum(:times) # 今天浏览量
        end

        render json: {
            v_0_count: v_0_count,
            v_1_count: info[:v_1_count],
            v_2_count: info[:v_2_count],
            v_3_count: info[:v_3_count],
            v_4_count: info[:v_4_count],
            v_5_count: info[:v_5_count],
            v_6_count: info[:v_6_count],
            v_7_count: info[:v_7_count]
 		}
    end

    private

    def set_v_info
        {
          v_1_count: Index::History.where(updated_at: 1.day.ago.midnight..Time.now.midnight).sum(:times), # 昨天浏览量
          v_2_count: Index::History.where(updated_at: 2.days.ago.midnight..1.day.ago.midnight).sum(:times), # 前天浏览量
          v_3_count: Index::History.where(updated_at: 3.days.ago.midnight..2.days.ago.midnight).sum(:times), # 大前天浏览量
          v_4_count: Index::History.where(updated_at: 4.days.ago.midnight..3.days.ago.midnight).sum(:times), # 前四天浏览量
          v_5_count: Index::History.where(updated_at: 5.days.ago.midnight..4.days.ago.midnight).sum(:times), # 前五天浏览量
          v_6_count: Index::History.where(updated_at: 6.days.ago.midnight..5.days.ago.midnight).sum(:times), # 前六天浏览量
          v_7_count: Index::History.where(updated_at: 7.days.ago.midnight..6.days.ago.midnight).sum(:times), # 前七天浏览量
        }
    end

end
