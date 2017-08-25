class AddAminRefToIndexProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_products do |t|
        t.references :admin, index: true
    end
  end
end
