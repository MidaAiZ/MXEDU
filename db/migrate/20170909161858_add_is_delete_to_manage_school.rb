class AddIsDeleteToManageSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :manage_schools, :is_deleted, :boolean, default: false
  end
end
