class AddPostRefToIndexPostComments < ActiveRecord::Migration[5.1]
  def change
    change_table :index_post_comments do |t|
        t.references :post, index: false
    end
    change_table :index_post_son_comments do |t|
        t.references :post_cmt, index: false
    end
    add_index :index_post_comments, :post_id, name: :index_post_comments_on_post_id
    add_index :index_post_son_comments, :post_cmt_id, name: :index_post_son_cmts_on_cmt_id
  end
end
