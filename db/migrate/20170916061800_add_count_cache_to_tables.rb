class AddCountCacheToTables < ActiveRecord::Migration[5.1]
  def change
    change_table :manage_schools do |t|
        t.integer :users_count, default: 0
        t.integer :products_count, default: 0
        t.integer :materials_count, default: 0
    end

    change_table :manage_product_cates do |t|
        t.integer :products_count, default: 0
        t.remove :count
    end

    change_table :manage_product_companies do |t|
        t.integer :products_count, default: 0
        t.remove :count
    end

    change_table :manage_material_cates do |t|
        t.integer :materials_count, default: 0
        t.remove :count
    end
  end
end
