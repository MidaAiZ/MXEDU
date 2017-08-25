class AddDetailsToIndexProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_products do |t|
        t.string :cover
        t.integer :readtimes
    end
  end
end
