class ChangeIndexOfIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    remove_index :index_materials, :name
    add_index :index_materials, [:name, :tag], name: :index_materials_on_name_tag
  end
end
