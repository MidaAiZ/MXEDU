class ChangeTypeOfPriceToFloat < ActiveRecord::Migration[5.1]
  def change
    change_table :index_products do |t|
      t.remove :price
      t.float :price, default: 0
    end
    change_column :index_orders, :price, :float
  end
end
