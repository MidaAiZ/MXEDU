json.array! @schools do |s|
    json.call(s, :id, :name, :city)
end
