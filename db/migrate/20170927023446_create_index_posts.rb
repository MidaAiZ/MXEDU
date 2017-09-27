class CreateIndexPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :index_posts do |t|
      t.string :name
      t.string :content
      t.integer :readtimes
      t.integer :comments_count
      t.integer :thumbs_count
      t.jsonb :info
      t.references :user, index: false
      t.references :school, index: false

      t.timestamps
    end
    add_index :index_posts, :name, name: :index_posts_on_name
    add_index :index_posts, :user_id, name: :index_posts_on_user_id
    add_index :index_posts, :school_id, name: :index_posts_on_manage_school_id
  end
end
