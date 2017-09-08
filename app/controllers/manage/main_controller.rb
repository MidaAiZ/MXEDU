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
             t_v_count: Index::History.where(updated_at: Time.now.midnight..Time.now).count # 今日访客
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

        info = Rails.cache.fetch("#{cache_key}", expires_in: 8.hours) do
            set_v_info
        end

        # 每新的一天清除旧缓存
        interval = Time.now - Time.now.midnight
        if (interval < 8.hours) && (interval < Time.now - Time.parse(info[:time]))
            Rails.cache.delete cache_key
            info = set_v_info
            info_0 = set_v_info_0
        else
            info_0 = Rails.cache.fetch("#{cache_key}_0", expires_in: 1.minutes) do
                set_v_info_0
            end
        end

        render json: {
            v_0_count: info_0[:v_0_count],
            v_1_count: info[:v_1_count],
            v_2_count: info[:v_2_count],
            v_3_count: info[:v_3_count],
            v_4_count: info[:v_4_count],
            v_5_count: info[:v_5_count],
            v_6_count: info[:v_6_count],
            v_7_count: info[:v_7_count],

            u_0_count: info_0[:u_0_count],
            u_1_count: info[:u_1_count],
            u_2_count: info[:u_2_count],
            u_3_count: info[:u_3_count],
            u_4_count: info[:u_4_count],
            u_5_count: info[:u_5_count],
            u_6_count: info[:u_6_count],
            u_7_count: info[:u_7_count],
 		}
    end

    private

    def set_v_info
        {
          # 产品点击量
          v_1_count: Index::History.where(updated_at: 1.day.ago.midnight..Time.now.midnight).sum(:times), # 昨天浏览量
          v_2_count: Index::History.where(updated_at: 2.days.ago.midnight..1.day.ago.midnight).sum(:times), # 前天浏览量
          v_3_count: Index::History.where(updated_at: 3.days.ago.midnight..2.days.ago.midnight).sum(:times), # 大前天浏览量
          v_4_count: Index::History.where(updated_at: 4.days.ago.midnight..3.days.ago.midnight).sum(:times), # 前四天浏览量
          v_5_count: Index::History.where(updated_at: 5.days.ago.midnight..4.days.ago.midnight).sum(:times), # 前五天浏览量
          v_6_count: Index::History.where(updated_at: 6.days.ago.midnight..5.days.ago.midnight).sum(:times), # 前六天浏览量
          v_7_count: Index::History.where(updated_at: 7.days.ago.midnight..6.days.ago.midnight).sum(:times), # 前七天浏览量

          # 访客量
          u_1_count: Index::History.where(updated_at: 1.day.ago.midnight..Time.now.midnight).count, # 昨天访客量
          u_2_count: Index::History.where(updated_at: 2.days.ago.midnight..1.day.ago.midnight).count, # 前天访客量
          u_3_count: Index::History.where(updated_at: 3.days.ago.midnight..2.days.ago.midnight).count, # 大前天访客量
          u_4_count: Index::History.where(updated_at: 4.days.ago.midnight..3.days.ago.midnight).count, # 前四天访客量
          u_6_count: Index::History.where(updated_at: 6.days.ago.midnight..5.days.ago.midnight).count, # 前六天访客量
          u_5_count: Index::History.where(updated_at: 5.days.ago.midnight..4.days.ago.midnight).count, # 前五天访客量
          u_7_count: Index::History.where(updated_at: 7.days.ago.midnight..6.days.ago.midnight).count, # 前七天访客量

          # 记录缓存时间
          time: Time.now
        }
    end

    def set_v_info_0
        {
            v_0_count: Index::History.where(updated_at: Time.now.midnight..Time.now).sum(:times),  # 今天浏览量
            u_0_count: Index::History.where(updated_at: Time.now.midnight..Time.now).count  # 今天访客量
        }
    end

end
