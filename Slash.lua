local Entity = require("Entity")

local Slash = class("Slash", Entity)

Slash.static.MOVE_SPEED = 180

function Slash:initialize(x, y, dir)
	self.x, self.y, self.z = x, y, -1
	self.dir = dir
	self.time = 0

	self.sprite = Resources.static:getImage("slash.png")
end

function Slash:update(dt)
	self.x = self.x + Slash.static.MOVE_SPEED * self.dir * dt

	self.time = self.time + dt
	if self.time > 0.1 then
		self:kill()
	end
end

function Slash:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, self.dir, 1, 10, 10)
end

return Slash
