class Manage::Image < ApplicationRecord
  mount_uploader :link, EditorImageUploader
end
