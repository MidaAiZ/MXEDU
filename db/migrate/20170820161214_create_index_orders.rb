class CreateIndexOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :index_orders do |t|
      t.integer :price
      t.string :product_name
      t.references :user, index: true
      t.references :products, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
