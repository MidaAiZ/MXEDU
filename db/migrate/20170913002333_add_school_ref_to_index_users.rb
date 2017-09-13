class AddSchoolRefToIndexUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :index_users do |t|
        t.references :school, index: false
    end
    add_index :index_users, :school_id, name: :index_users_on_school_id
  end
end
