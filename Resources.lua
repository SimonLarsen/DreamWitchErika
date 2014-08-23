local Resources = class("Resources")

Resources.static.images = {}

function Resources.static:getImage(path)
	path = "data/images/" .. path
	if self.images[path] == nil then
		self.images[path] = love.graphics.newImage(path)
	end
	return self.images[path]
end

Resources.static.animators = {}

function Resources.static:getAnimator(path)
	path = "data/animators/" .. path
	if self.animators[path] == nil then
		local f = loadfile(path)
		self.animators[path] = f()
	end
	return self.animators[path]
end

return Resources
