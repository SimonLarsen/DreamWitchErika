local Entity = require("Entity")

local Sprite = class("Sprite", Entity)

function Sprite:initialize(x, y, z, image)
	self.x, self.y = x, y
	self.z = z
	self.image = image
	self.ox = image:getWidth()/2
	self.oy = image:getHeight()/2
end

function Sprite:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end

return Sprite
