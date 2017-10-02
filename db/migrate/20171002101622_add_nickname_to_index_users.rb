class AddNicknameToIndexUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :index_users, :nickname, :string  
  end
end
