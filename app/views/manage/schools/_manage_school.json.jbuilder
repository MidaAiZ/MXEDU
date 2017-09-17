json.extract! manage_school, :id, :city, :name, :cate, :sign, :products_count, :users_count, :materials_count
json.created_at manage_school.created_at.strftime('%Y-%m-%d %H:%M:%S')
