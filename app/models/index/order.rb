class Index::Order < ApplicationRecord
	belongs_to :user,
			  class_name: 'Index::User',
			  foreign_key: :user_id
end
