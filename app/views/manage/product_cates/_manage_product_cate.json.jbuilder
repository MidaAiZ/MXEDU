json.extract! manage_product_cate, :id, :name, :products_count, :created_at
json.created_at manage_product_cate.created_at.strftime('%Y-%m-%d %H:%M:%S')
