class CreateManageMaterialCates < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_material_cates do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
