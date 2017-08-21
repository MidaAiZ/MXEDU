class ChangeDetailsOfIndexHistories < ActiveRecord::Migration[5.1]
  def change
    change_table :index_histories do |t|
        t.remove :products_type
        t.remove :products_id
        t.references :p, index: true
    end
  end
end
