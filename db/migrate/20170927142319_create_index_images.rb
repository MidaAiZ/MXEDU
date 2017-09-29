class CreateIndexImages < ActiveRecord::Migration[5.1]
  def change
    create_table :index_images do |t|
        t.string :link
        t.references :user
    end
    add_index :index_images, :user_id, name: :index_images_on_user_id
  end
end
