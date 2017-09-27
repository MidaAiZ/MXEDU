class CreateManagePostCate < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_post_cates do |t|
        t.string :name
        t.integer :posts_count

        t.timestamps
    end
    change_table :index_posts do |t|
        t.references :cate, index: false
    end
    add_index :index_posts, :cate_id, name: :index_posts_on_cate_id
  end
end
