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
		local f = love.filesystem.load(path)
		self.animators[path] = f()
	end
	return self.animators[path]
end

Resources.static.sounds = {}

function Resources.static:getSound(path)
	path = "data/sounds/" .. path
	if self.sounds[path] == nil then
		self.sounds[path] = love.audio.newSource(path, "static")
	end
	return self.sounds[path]
end

return Resources
