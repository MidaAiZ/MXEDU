class AddCompanyRefToIndexProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :index_products do |t|
        t.references :company
    end
    add_index :index_products, :company_id, name: :index_products_on_company_id
  end
end
