json.extract! manage_product_company, :id, :name, :products_count, :cate
json.created_at manage_product_company.created_at.strftime('%Y-%m-%d %H:%M:%S')
