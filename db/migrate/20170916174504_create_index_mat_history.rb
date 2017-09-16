class CreateIndexMatHistory < ActiveRecord::Migration[5.1]
  def change
    create_table :index_mat_histories do |t|
        t.bigint :user_id
        t.string :remote_ip
        t.bigint :material_id
        t.integer :times, default: 0
        t.string :material_name

        t.timestamps
    end
    add_index :index_mat_histories, :user_id, name: :index__mat_histories_on_user_id
    add_index :index_mat_histories, :material_id, name: :index__mat_histories_on_mat_id  end
end
