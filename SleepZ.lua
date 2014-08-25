local Entity = require("Entity")
local Animation = require("Animation")

local SleepZ = class("SleepZ", Entity)

function SleepZ:initialize(x, y)
	self.x, self.y = x, y
	self.z = 2

	self.anim = Animation(Resources.static:getImage("sleep.png"), 20, 20, 0.2)
	self.anim:update(math.random()*2)
end

function SleepZ:update(dt)
	self.anim:update(dt * (math.gauss()/2+1))
end

function SleepZ:draw()
	self.anim:draw(self.x, self.y, 0, 1, 1, 10, 10)
end

return SleepZ
