class Manage::MainController < ManageController
    before_action :require_login

    def index
        @new_users = Index::User.new_user.includes(:school)
    end

    def counts
       info = Rails.cache.fetch("#{cache_key}", expires_in: 5.minutes) do
         set_counts
       end

       render json: info.to_json
    end

    def products_count
        info = Rails.cache.fetch("#{cache_key}", expires_in: 10.minutes) do
           cates = Manage::ProductCate.limit(5)
           counts = {}
           cates.each do |c|
             counts[c.name] = c.products.count
           end
           counts["其它"] = (counts["其它"] || 0 ) +
                            Index::Product.where.not(cate_id: cates.map{|c| c.id}).count +
                            Index::Product.where(cate_id: nil).count
           counts
        end

        render json: info.to_json
    end

    def total_count
        info = Rails.cache.fetch("#{cache_key}", expires_in: 10.minutes) do
          set_m_p_v_info
        end

        render json: info.to_json
    end

    def viewers_count

        info = Rails.cache.fetch("#{cache_key}", expires_in: 8.hours) do
            set_v_info
        end

        # 每新的一天清除旧缓存
        interval = Time.now - Time.now.midnight
        if (interval < 8.hours) && (interval < Time.now - info[:time])
            Rails.cache.delete cache_key
            info = set_v_info
            info_0 = set_v_info_0
        else
            info_0 = Rails.cache.fetch("#{cache_key}_0", expires_in: 1.minutes) do
                set_v_info_0
            end
        end

        render json: info.merge(info_0).to_json
    end

    private

    def set_counts
        {
           u_count: Index::User.count, # 用户总数
           p_count: Index::Product.count, # 产品总数
           a_count: Index::Appoint.count, # 预约总数
           m_count: Index::Material.count, # 总资料数
        #    t_u_count: Index::History.where(created_at: Time.now.midnight..Time.now).count, # 今日新增用户
           t_a_count: Index::Appoint.where(created_at: Time.now.midnight..Time.now).count, # 今日预约数
           t_v_count: Index::History.where(updated_at: Time.now.midnight..Time.now).count +
                      Index::MatHistory.where(updated_at: Time.now.midnight..Time.now).count # 今日访客
        }
    end

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

    def set_m_p_v_info
        {
            m_t_v_count: Index::MatHistory.where(updated_at: Time.now.midnight..Time.now).count,  # 今天访客量
            m_v_count: Index::MatHistory.count,  # 资料总访客量
            m_d_count: Index::Material.sum(:dload_count),  # 总下载次数
            p_t_v_count: Index::History.where(updated_at: Time.now.midnight..Time.now).count,  # 今天访客量
            p_v_count: Index::History.count,  # 产品总访客量
        }
    end
end
