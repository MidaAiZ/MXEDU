class CreateIndexProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :index_products do |t|
      t.string :name
      t.string :price
      t.string :intro
      t.string :type
      t.jsonb :info

      t.timestamps
    end
    add_index :index_products, [:name, :type]
    add_index :index_products, :info, using: :gin
  end
end
