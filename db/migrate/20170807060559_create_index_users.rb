class CreateIndexUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :index_users do |t|
      t.string :number
      t.string :password_digest
      t.string :phone
      t.string :email
      t.string :name
      t.string :sex
      t.jsonb :info

      t.timestamps
    end
    add_index :index_users, :info, name: :index_users_on_info, using: :gin
  end
end
