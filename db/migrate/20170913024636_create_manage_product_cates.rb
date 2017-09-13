class CreateManageProductCates < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_product_cates do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
