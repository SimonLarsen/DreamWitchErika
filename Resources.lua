local Resources = class("Resources")

Resources.static.images = {}

function Resources.static:getImage(path)
	path = "data/images/" .. path
	if Resources.static.images[path] == nil then
		Resources.static.images[path] = love.graphics.newImage(path)
	end
	return Resources.static.images[path]
end

return Resources
