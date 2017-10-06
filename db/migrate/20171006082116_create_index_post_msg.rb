class CreateIndexPostMsg < ActiveRecord::Migration[5.1]
  def change
    create_table :index_post_msgs do |t|
      t.string :msg
      t.integer :state, default: 0
      t.references :receiver, index: false
      t.references :sender, index: false
      t.references :resource, polymorphic: true, index: false
      t.string :uniq_key 
      t.timestamp :created_at

    end
    add_index :index_post_msgs, [:receiver_id], name: :index_post_msgs_on_receiver_id
    add_index :index_post_msgs, [:resource_id, :resource_type], name: :index_post_msgs_on_rsc_id_type
  end
end
