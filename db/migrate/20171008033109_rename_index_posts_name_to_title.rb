class RenameIndexPostsNameToTitle < ActiveRecord::Migration[5.1]
  def change
    rename_column :index_posts, :name, :title
    rename_index :index_posts, :index_posts_on_name, :index_posts_on_title
  end
end
