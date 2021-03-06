class Index::User < ApplicationRecord
    mount_uploader :avatar, UserAvatarUploader # 头像上传

    # 用于上传头像时保存图片参数
    attr_accessor :x, :y, :width, :height, :rotate
    store_accessor :info, :collage, :grade, :major

    # 使用插件建立用户密码验证体系
    has_secure_password

    belongs_to :school,
                counter_cache: true,
                class_name: 'Manage::School',
                foreign_key: :school_id,
                optional: true

    has_many :posts, -> { state_ok },
            class_name: 'Index::Post',
            foreign_key: :user_id

    has_many :histories,
            class_name: 'Index::History',
            foreign_key: :user_id

    has_many :mat_histories,
            class_name: 'Index::MatHistory',
            foreign_key: :user_id

    has_many :appoints,
            class_name: 'Index::Appoint',
            foreign_key: :user_id

    has_many :orders,
            class_name: 'Index::Order',
            foreign_key: :user_id

    has_many :images,
            class_name: 'Index::Image',
            foreign_key: :user_id

    has_many :thumbs,
             class_name: 'Index::Thumb',
             foreign_key: :user_id

    has_many :post_comments,
             class_name: 'Index::PostComment',
             foreign_key: :user_id

    has_many :post_son_comments,
             class_name: 'Index::PostSonComment',
             foreign_key: :user_id

    has_many :post_msgs,
              class_name: 'Index::PostMsg',
              foreign_key: :receiver_id

    has_many :login_records,
             class_name: 'Manage::LoginRecord',
             foreign_key: :user_id


      validates :number, presence: true, uniqueness: { message: '该帐号已被注册' },
                         length: { minimum: 2, maximum: 16 },
                         format: { with: Validate::VALID_ACCOUNT_REGEX },
                         allow_blank: false
      validates :name,
                   length: { minimum: 2, too_short: "姓名长度应大于%{count}个字符",
                             maximum: 16, too_long: '姓名最长允许%{count}个字符' }
      validates :nickname,  uniqueness: { message: '该昵称已被占用' }, allow_blank: true,
                  length: { maximum: 16, too_long: '昵称最长允许%{count}个字符' }
      validates :password, presence: true, length: { minimum: 8, maximum: 16 },
                           format: { with: Validate::VALID_PASSWORD_REGEX },
                           allow_blank: false, on: [:create]
      validates :password_digest, presence: true, allow_blank: false, on: [:update]
      validates :email, presence: false, uniqueness: { message: '该邮箱已被注册' },
                        length: { maximum: 255 },
                        format: { with: Validate::VALID_EMAIL_REGEX },
                        allow_blank: true
      validates :phone, presence: true, uniqueness: { message: '该手机号已被注册' },
                        format: { with: Validate::VALID_PHONE_REGEX },
                        allow_blank: false
      validates :sex, length: { maximum: 2, too_long: '性别最长允许%{count}个字符' },
                    inclusion: %w( 男 女 男生 女生 ), allow_blank: true

      default_scope { order(id: :DESC) }
      scope :new_user, ->() { limit(3) }

end
