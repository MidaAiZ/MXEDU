class Manage::Fileworker < ApplicationRecord
  mount_uploader :file, FileworkerUploader
end
