class AddIsDeletedToManageCate < ActiveRecord::Migration[5.1]
  def change
    add_column :manage_material_cates, :is_deleted, :boolean, default: false
  end
end
