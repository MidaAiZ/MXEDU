class AddRemoteIpToIndexHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :index_histories, :remote_ip, :string
    add_index :index_histories, :remote_ip, name: :index_histories_on_remote_ip
  end
end
