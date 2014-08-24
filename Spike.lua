local Entity = require("Entity")
local Animation = require("Animation")

local Spike = class("Spike", Entity)

function Spike:initialize(x, y)
	self.x, self.y = x, y
	self.z = 1

	self.anim = Animation(Resources.static:getImage("spike.png"), 20, 20, 0.08)
end

function Spike:update(dt)
	self.anim:update(dt)
end

function Spike:draw()
	self.anim:draw(self.x, self.y, 0, 1, 1, 10, 10)
end

return Spike
