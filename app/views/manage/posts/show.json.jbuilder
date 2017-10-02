# json.partiali! "index/posts/post", post: @post
json.extract! @post, :id, :content, :readtimes, :comments_count, :thumbs_count, :created_at, :images
