json.array! @posts do |p|
    json.call(p, :id)
	json.name p.content.slice(0, 10)
end
