json.extract! index_product, :id, :name, :price, :intro, :details, :cate, :created_at, :updated_at
json.url index_product_path(index_product, format: :json)
