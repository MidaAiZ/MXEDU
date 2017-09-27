json.extract! post, :id, :name, :content, :readtimes, :comments_count, :thumbs_count, :created_at, :updated_at
json.url post_url(post, format: :json)
