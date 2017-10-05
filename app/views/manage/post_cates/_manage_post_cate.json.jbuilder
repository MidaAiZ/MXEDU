json.extract! manage_post_cate, :id, :name, :posts_count, :created_at
json.created_at manage_post_cate.created_at.strftime('%Y-%m-%d %H:%M:%S')
