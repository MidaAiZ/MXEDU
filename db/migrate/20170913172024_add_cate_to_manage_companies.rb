class AddCateToManageCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :manage_product_companies, :cate, :string
  end
end
