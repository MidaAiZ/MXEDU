class CreateIndexThumbs < ActiveRecord::Migration[5.1]
  def change
    create_table :index_thumbs do |t|
        t.references :user, index: false
        t.references :resource, polymorphic: true, index: false

        t.timestamps
    end
    add_index :index_thumbs, :user_id, name: :index_thumbs_on_user_id
    add_index :index_thumbs, [:resource_id, :resource_type], name: :index_thumbs_on_rsc_id_type
  end
end
