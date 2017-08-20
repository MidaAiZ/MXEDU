json.extract! index_product, :id, :name, :price, :intro, :info, :created_at, :updated_at
json.url index_product_url(index_product, format: :json)
