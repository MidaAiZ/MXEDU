class AddTagToIndexProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_products do |t|
        t.string :tag
    end
    add_index :index_products, [:name, :tag], name: :index_products_on_name_tag
  end
end
