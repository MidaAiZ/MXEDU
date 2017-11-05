class CreateManageLoginRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_login_records do |t|
      t.string :ip
      t.timestamp :time
      t.references :user, index: false
    end
    add_index :manage_login_records, :ip, name: :index_mng_login_records_on_ip
    add_index :manage_login_records, :user_id, name: :index_mng_login_records_on_user_id
  end
end
