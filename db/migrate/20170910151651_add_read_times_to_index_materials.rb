class AddReadTimesToIndexMaterials < ActiveRecord::Migration[5.1]
  def change
    add_column :index_materials, :readtimes, :integer, default: 0
  end
end
