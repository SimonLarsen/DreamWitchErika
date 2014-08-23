local Entity = require("Entity")
local Animation = require("Animation")

local Slash = class("Slash", Entity)

function Slash:initialize(x, y, dir, xspeed)
	self.x, self.y, self.z = x, y, -1
	self.xspeed = xspeed or 0
	self.dir = dir
	self.time = 0

	local sprite = Resources.static:getImage("slash.png")
	self.anim = Animation(sprite, 11, 17, 0.0667, 5, 8)
end

function Slash:update(dt)
	self.time = self.time + dt
	self.x = self.x + self.xspeed * dt

	self.anim:update(dt)

	if self.time > 0.2 then
		self:kill()
	end
end

function Slash:draw()
	self.anim:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
end

return Slash
