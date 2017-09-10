class AddIsDeleteToIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :index_materials, :is_deleted, :boolean, default: false
  end
end
