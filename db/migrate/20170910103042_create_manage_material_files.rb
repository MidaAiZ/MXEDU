class CreateManageMaterialFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_material_files do |t|
        t.string "file"
        t.references "material"
        t.string "name"
        t.string "size"
        t.string "f_type"

        t.timestamps
    end
    add_index :manage_material_files, :name, name: :index_manage_material_files_on_name
  end
end
