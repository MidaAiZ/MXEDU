class AddCateRefToIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    remove_column :index_materials, :cate
    add_column :index_materials, :cate_id, :bigint
    add_index :index_materials, :cate_id, name: :index_materials_on_cate_id
  end
end
