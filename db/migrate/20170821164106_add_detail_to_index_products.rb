class AddDetailToIndexProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :index_products, :details, :string
  end
end
