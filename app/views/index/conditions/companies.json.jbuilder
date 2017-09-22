json.array! @companies do |c|
    json.call(c, :id, :name)
end
