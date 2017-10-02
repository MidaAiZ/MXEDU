class AddTagToIndexPosts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_posts do |t|
        t.string :tag
    end
    add_index :index_posts, :tag, name: :index_posts_on_tag
  end
end
