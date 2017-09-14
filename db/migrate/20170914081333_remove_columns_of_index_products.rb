class RemoveColumnsOfIndexProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_products do |t|
        t.remove :cate
    end
    remove_index :index_products, name: :index_index_products_on_company_id
  end
end
