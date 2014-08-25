local Entity = require("Entity")
local Animator = require("Animator")
local BoxCollider = require("BoxCollider")

local Pickup = class("Pickup", Entity)

function Pickup:initialize(x, y, prop)
	self.x, self.y = x, y+10
	self.z = 2
	self.name = "pickup"
	self.collider = BoxCollider(8, 8, 0, -14)
	self.dir = tonumber(prop.dir)

	self.animator = Animator(Resources.static:getAnimator("pickup.lua"))
	if self.taken then
		self.animator:setProperty("taken", true)
	end
end

function Pickup:update(dt)
	self.animator:update(dt)
end

function Pickup:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1, 20, 20)
end

return Pickup
