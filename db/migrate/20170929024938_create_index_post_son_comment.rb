class CreateIndexPostSonComment < ActiveRecord::Migration[5.1]
  def change
    create_table :index_post_son_comments do |t|
      t.string :content
      t.integer :thumbs_count
      t.references :user, index: false

      t.timestamps
    end
    add_index :index_post_son_comments, :user_id, name: :index_post_son_comments_on_user_id
  end
end
