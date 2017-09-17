class AddIsDeletedToManageAdmins < ActiveRecord::Migration[5.1]
  def change
    change_table :manage_admins do |t|
        t.boolean :is_deleted, default: false
    end
  end
end
