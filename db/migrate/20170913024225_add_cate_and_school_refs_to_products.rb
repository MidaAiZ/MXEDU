class AddCateAndSchoolRefsToProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_products do |t|
        t.references :school, index: false
        t.references :cate, index: false
    end
    add_index :index_products, :school_id, name: :index_products_on_school_id
    add_index :index_products, :cate_id, name: :index_products_on_cate_id
  end
end
