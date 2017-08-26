class AddDisPriceIndexProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :index_products, :dis_price, :float
  end
end
