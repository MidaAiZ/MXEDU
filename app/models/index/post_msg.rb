class Index::PostMsg < ApplicationRecord
	belongs_to :receiver,
				class_name: 'Index::User',
				foreign_key: :receiver_id,
				optional: true # 拒绝框架本身的频繁验证

	belongs_to :sender,
				class_name: 'Index::User',
				foreign_key: :sender_id,
				optional: true # 拒绝框架本身的频繁验证

	belongs_to :resource, polymorphic: true, optional: true

	validates :state, inclusion: [0, 1]
	validates :resource_id, presence: true
	validates :sender_id, presence: true

	scope :unread, -> { where(state: unread_state) }
	scope :read, -> { where(state: read_state) }
	default_scope -> { order(id: :DESC) }

	def self._create sender, rsc, msg, key
		return if sender == rsc.user
		_self = self.new
		_self.sender = sender
		_self.resource = rsc
		_self.receiver = rsc.user
		_self.uniq_key = key
		_self.msg = msg
		_self.created_at = Time.now
		_self.save!
		add_unread_count rsc.user
	end

	def self._delete sender, rsc, key
		msg = rsc.msgs.find_by sender_id: sender.id, uniq_key: key
		if msg
			msg.destroy
			sub_unread_count rsc.user if msg.unread?
		end
	end

	def read!
		self.update! state: read_state
	end

	def unread!
		self.update! state: unread_state
	end

	def read?
		self.state == read_state
	end

	def unread?
		self.state == unread_state
	end

	def read_state
		1
	end

	def unread_state
		0
	end

	def self.read_state
		1
	end

	def self.unread_state
		0
	end

	def self.unread_count user
		key = self.unread_cache_key user
		$redis.get(key) || 0
	end

	def self.add_unread_count user
		key = self.unread_cache_key user
		count = ($redis.get(key) || 0).to_i
		$redis.SET(key, count + 1)
		$redis.EXPIRE key, 12*24*60*60 # 保存12天
	end

	def self.clear_unread_count user
		key = self.unread_cache_key user
		$redis.SET(key, nil)
	end

	def self.sub_unread_count user
		key = self.unread_cache_key user
		count = ($redis.get(key) || 0).to_i
		$redis.SET(key, count - 1) if count > 0
	end

	def self.unread_cache_key user
		"#{user.id}_unread_post_msgs_count"
	end
end
