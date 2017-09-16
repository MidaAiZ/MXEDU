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
                foreign_key: 'school_id',
                optional: true

    has_many :histories,
            class_name: 'Index::History',
            foreign_key: 'user_id'

    has_many :mat_histories,
            class_name: 'Index::MatHistory',
            foreign_key: 'user_id'

    has_many :appoints,
            class_name: 'Index::Appoint',
            foreign_key: 'user_id'

    has_many :orders,
            class_name: 'Index::Order',
            foreign_key: 'user_id'

      validates :number, presence: true, uniqueness: { message: '该帐号已被注册' },
                         length: { minimum: 2, maximum: 16 },
                         format: { with: Validate::VALID_ACCOUNT_REGEX },
                         allow_blank: false
      validates :name,
                   length: { minimum: 2, too_short: "名字长度应大于%{count}个字符",
                             maximum: 32, too_long: '名字最长允许%{count}个字符' }
      validates :password, presence: true, length: { minimum: 6, maximum: 20 },
                           format: { with: Validate::VALID_PASSWORD_REGEX },
                           allow_blank: false, on: [:create   ]
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

      default_scope { order('index_users.created_at DESC') }
      scope :new_user, ->() { limit(4) }

end
