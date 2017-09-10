class CreateIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :index_materials do |t|
        t.string :name
        t.string :cate
        t.string :tag
        t.string :attach
        t.references :school, index: false
        t.references :admin, index: false
        t.jsonb :info

        t.timestamps
      end

      add_index :index_materials, :name, name: :index_materials_on_name
      add_index :index_materials, [:cate, :tag], name: :index_materials_on_cate_tag
      add_index :index_materials, :school_id, name: :index_materials_on_school_id
      add_index :index_materials, :admin_id, name: :index_materials_on_admin_id
  end
end
