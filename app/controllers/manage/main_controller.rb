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
           pt_count: Index::Post.state_ok.count, # 帖子总数
           m_count: Index::Material.count, # 总资料数
        #    t_u_count: Index::History.where(created_at: Time.now.midnight..Time.now).count, # 今日新增用户
           t_a_count: Index::Appoint.where(created_at: Time.now.midnight..Time.now).count, # 今日预约数
           t_v_count: Manage::LoginRecord.where(time: Time.now.midnight..Time.now).count # 今日访客
        }
    end

    def set_v_info
        {
          # 产品点击量
          p_1_count: Index::History.where(updated_at: 1.day.ago.midnight..Time.now.midnight).sum(:times), # 昨天浏览量
          p_2_count: Index::History.where(updated_at: 2.days.ago.midnight..1.day.ago.midnight).sum(:times), # 前天浏览量
          p_3_count: Index::History.where(updated_at: 3.days.ago.midnight..2.days.ago.midnight).sum(:times), # 大前天浏览量
          p_4_count: Index::History.where(updated_at: 4.days.ago.midnight..3.days.ago.midnight).sum(:times), # 前四天浏览量
          p_5_count: Index::History.where(updated_at: 5.days.ago.midnight..4.days.ago.midnight).sum(:times), # 前五天浏览量
          p_6_count: Index::History.where(updated_at: 6.days.ago.midnight..5.days.ago.midnight).sum(:times), # 前六天浏览量
          p_7_count: Index::History.where(updated_at: 7.days.ago.midnight..6.days.ago.midnight).sum(:times), # 前七天浏览量

          # 资料点击量
          m_1_count: Index::MatHistory.where(updated_at: 1.day.ago.midnight..Time.now.midnight).sum(:times), # 昨天访客量
          m_2_count: Index::MatHistory.where(updated_at: 2.days.ago.midnight..1.day.ago.midnight).sum(:times), # 前天访客量
          m_3_count: Index::MatHistory.where(updated_at: 3.days.ago.midnight..2.days.ago.midnight).sum(:times), # 大前天访客量
          m_4_count: Index::MatHistory.where(updated_at: 4.days.ago.midnight..3.days.ago.midnight).sum(:times), # 前四天访客量
          m_6_count: Index::MatHistory.where(updated_at: 6.days.ago.midnight..5.days.ago.midnight).sum(:times), # 前六天访客量
          m_5_count: Index::MatHistory.where(updated_at: 5.days.ago.midnight..4.days.ago.midnight).sum(:times), # 前五天访客量
          m_7_count: Index::MatHistory.where(updated_at: 7.days.ago.midnight..6.days.ago.midnight).sum(:times), # 前七天访客量

          # 帖子点击量
          pt_1_count: Index::PostHistory.where(updated_at: 1.day.ago.midnight..Time.now.midnight).sum(:times), # 昨天访客量
          pt_2_count: Index::PostHistory.where(updated_at: 2.days.ago.midnight..1.day.ago.midnight).sum(:times), # 前天访客量
          pt_3_count: Index::PostHistory.where(updated_at: 3.days.ago.midnight..2.days.ago.midnight).sum(:times), # 大前天访客量
          pt_4_count: Index::PostHistory.where(updated_at: 4.days.ago.midnight..3.days.ago.midnight).sum(:times), # 前四天访客量
          pt_6_count: Index::PostHistory.where(updated_at: 6.days.ago.midnight..5.days.ago.midnight).sum(:times), # 前六天访客量
          pt_5_count: Index::PostHistory.where(updated_at: 5.days.ago.midnight..4.days.ago.midnight).sum(:times), # 前五天访客量
          pt_7_count: Index::PostHistory.where(updated_at: 7.days.ago.midnight..6.days.ago.midnight).sum(:times), # 前七天访客量

          # 记录缓存时间
          time: Time.now
        }
    end

    def set_v_info_0
        {
            p_0_count: Index::History.where(updated_at: Time.now.midnight..Time.now).sum(:times),  # 产品今天浏览量
            m_0_count: Index::MatHistory.where(updated_at: Time.now.midnight..Time.now).sum(:times),  # 资料今天浏览量
            pt_0_count: Index::PostHistory.where(updated_at: Time.now.midnight..Time.now).sum(:times),  # 帖子今天浏览量
        }
    end

    def set_m_p_v_info
        {
            m_t_v_count: Index::MatHistory.where(updated_at: Time.now.midnight..Time.now).count,  # 资料今天访客量
            m_v_count: Index::MatHistory.count,  # 资料总访客量
            m_d_count: Index::Material.sum(:dload_count),  # 总下载次数
            p_t_v_count: Index::History.where(updated_at: Time.now.midnight..Time.now).count,  # 产品今天访客量
            p_v_count: Index::History.count,  # 产品总访客量
            total_viewers_count: Manage::LoginRecord.count #本站总访客量
        }
    end
end
