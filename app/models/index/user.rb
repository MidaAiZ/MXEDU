class Index::User < ApplicationRecord
	# mount_uploader :avatar, UserAvatarUploader # 头像上传

    # 用于上传头像时保存图片参数
    attr_accessor :x, :y, :width, :height, :rotate

    # 使用插件建立用户密码验证体系
    has_secure_password
end
