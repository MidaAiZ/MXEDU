class AddCoverToIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :index_materials, :cover, :string
  end
end
