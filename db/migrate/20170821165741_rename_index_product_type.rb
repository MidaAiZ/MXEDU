class RenameIndexProductType < ActiveRecord::Migration[5.1]
  def change
    rename_column :index_products, :type, :cate
  end
end
