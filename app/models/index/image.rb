class Index::Image < ApplicationRecord
  mount_uploader :link, IndexImageUploader

  belongs_to :user,
  			  class_name: "Index::User",
			  foreign_key: :user_id
end
