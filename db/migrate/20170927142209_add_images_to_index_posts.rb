class AddImagesToIndexPosts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_posts do |t|
        t.jsonb :images
    end
  end
end
