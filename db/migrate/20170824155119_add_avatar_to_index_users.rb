class AddAvatarToIndexUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :index_users, :avatar, :string
  end
end
