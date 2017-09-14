class AddGradeToIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :index_materials, :grade, :string
    add_index :index_materials, :grade, name: :index_materials_on_grade
  end
end
