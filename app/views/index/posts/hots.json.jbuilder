json.array! @posts do |p|
    json.call(p, :id)
	json.title p.title || p.content.slice(0, 10)
end
