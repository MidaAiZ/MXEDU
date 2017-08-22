class CreateManageAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_admins do |t|
      t.string :number
      t.string :password_digest
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
