class ChangeDetailsOfIndexProducts < ActiveRecord::Migration[5.1]
  def change
      remove_column :index_products, :readtimes
      add_column :index_products, :readtimes, :integer, default: 0
  end
end
