class AddDloadCountToIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    change_table :index_materials do |t|
        t.integer :dload_count, default: 0
    end
    change_table :manage_material_files do |t|
        t.integer :dload_count, default: 0
    end
  end
end
