class AddProductRefToIndexAppoint < ActiveRecord::Migration[5.1]
  def change
    change_table :index_appoints do |t|
        t.references :product, index: true
    end
  end
end
