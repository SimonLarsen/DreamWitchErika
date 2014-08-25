local Entity = require("Entity")
local Animation = require("Animation")
local BoxCollider = require("BoxCollider")

local Pickup = class("Pickup", Entity)

function Pickup:initialize(x, y, prop)
	self.x, self.y = x, y+10
	self.z = 2
	self.name = "pickup"
	self.collider = BoxCollider(8, 8, 0, -14)
	self.dir = tonumber(prop.dir)

	if self.taken then
		local sprite = Resources.static:getImage("pickup_taken.png")
		self.anim = Animation(sprite, 40, 40, 0.1)
	else
		local sprite = Resources.static:getImage("pickup.png")
		self.anim = Animation(sprite, 40, 40, 0.1)
	end
end

function Pickup:update(dt)
	self.anim:update(dt)
end

function Pickup:draw()
	self.anim:draw(self.x, self.y, 0, self.dir, 1, 20, 20)
end

return Pickup
