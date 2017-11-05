class Manage::LoginRecord < ApplicationRecord
	belongs_to :user,
				class_name: 'Index::User',
				foreign_key: :user_id,
				optional: true

	default_scope -> { order(id: :DESC) }

	def self._create ip, user
		_self = self.find_or_initialize_by(ip: ip)
		_self = self.new(ip: ip) if (_self.id && (Time.now - _self.time > 3.hours))
		_self.user = user if user
		_self.time = Time.now
		_self.save
		_self
	end
end
