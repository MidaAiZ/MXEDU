class CreateIndexPostHistory < ActiveRecord::Migration[5.1]
  def change
    create_table :index_post_histories do |t|
        t.bigint :user_id
        t.string :remote_ip
        t.bigint :post_id
        t.integer :times, default: 0

        t.timestamps
    end
    add_index :index_post_histories, :user_id, name: :index_post_histories_on_user_id
    add_index :index_post_histories, :post_id, name: :index_post_histories_on_post_id
  end
end
