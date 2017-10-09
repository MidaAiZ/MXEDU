json.array! @posts do |p|
    json.call(p, :id)
	json.title p.title || p.content
end
