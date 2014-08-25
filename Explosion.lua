local Entity = require("Entity")
local Animation = require("Animation")

local Explosion = class("Explosion", Entity)

function Explosion:initialize(x, y)
	self.x, self.y = x, y
	self.z = 1

	self.animation = Animation(Resources.static:getImage("explosion.png"), 30, 30, 0.1, true)
	self.time = 0
end

function Explosion:update(dt)
	self.animation:update(dt)

	self.time = self.time + dt
	if self.time > 2.1 then
		self:kill()
	end
end

function Explosion:draw()
	self.animation:draw(self.x, self.y, 0, 1, 1, 15, 15)
end

return Explosion
