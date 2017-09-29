class AddImagesToIndexPostComments < ActiveRecord::Migration[5.1]
  def change
    change_table :index_post_comments do |t|
      t.jsonb :images
    end
  end
end
