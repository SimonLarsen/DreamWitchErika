local Entity = require("Entity")

local Fade = class("Entity", Entity)

Fade.static.FROM_BLACK = 0
Fade.static.TO_BLACK = 1

function Fade:initialize(direction, duration)
	self.x, self.y, self.z = 0, 0, -10

	self.direction = direction
	self.duration = duration
	self.time = duration
end

function Fade:update(dt)
	self.time = self.time - dt
	if self.time <= 0 then
		self:kill()
	end
end

function Fade:gui()
	local a = self.time / self.duration
	if self.direction == Fade.static.TO_BLACK then
		a = 1-a
	end
	a = math.cap(a, 0, 1) * 255
	love.graphics.setColor(0, 0, 0, a)
	love.graphics.rectangle("fill", 0, 0, WIDTH*SCALE, HEIGHT*SCALE)
	love.graphics.setColor(255,255,255,255)
end

return Fade
