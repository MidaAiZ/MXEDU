class Manage::Admin < ApplicationRecord
    mount_uploader :avatar, AdminAvatarUploader # 头像上传
    # 用于上传头像时保存图片参数
    attr_accessor :x, :y, :width, :height, :rotate

    # 使用插件建立用户密码验证体系
    has_secure_password

    has_many :products, -> { with_del },
             class_name: 'Index::Product',
             foreign_key: :admin_id

    has_many :materials, -> { with_del },
             class_name: 'Index::materials',
             foreign_key: :admin_id

     validates :number, presence: true, uniqueness: { message: '该帐号已被注册' },
                        length: { minimum: 2, maximum: 16 },
                        format: { with: Validate::VALID_ACCOUNT_REGEX },
                        allow_blank: false
     validates :role, presence: true,
                  length: { minimum: 1, too_short: "管理员角色不能为空",
                            maximum: 32, too_long: '角色名%{count}个字符' },
                  inclusion: ['super', 'common']
     validates :password, presence: true, length: { minimum: 6, maximum: 20 },
                          format: { with: Validate::VALID_PASSWORD_REGEX },
                          allow_blank: false, on: [:create   ]
    validates :password_digest, presence: true, allow_blank: false, on: [:update]


    # validates :number, uniqueness: true
    # validates :password_digest, allow_blank: false

    scope :un_deleted, ->() { where(is_deleted: false) }
    scope :with_del, -> { unscope(where: :is_deleted) }

    def super?
        self.role == 'super'
    end

    def has_role? role
        self.role == role.to_s
    end
end
