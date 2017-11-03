json.extract! index_post_notice, :id, :name, :price, :intro, :details, :cate, :created_at, :updated_at
json.url index_post_notice_path(index_post_notice, format: :json)
