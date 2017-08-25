class Manage::Admin < ApplicationRecord

    # 使用插件建立用户密码验证体系
    has_secure_password

    has_many :products,
             class_name: 'Index::Product',
             foreign_key: :admin_id

    def super?
        self.role == 'super'
    end

    def has_role? role
        self.role == role.to_s
    end
end
