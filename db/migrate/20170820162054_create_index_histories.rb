class CreateIndexHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :index_histories do |t|
      t.string :product_name
      t.references :user, index: true
      t.references :products, polymorphic: true

      t.timestamps
    end
    add_index :index_histories, [:products_id, :products_type], name: :index_histories_on_product_id_type
  end
end
