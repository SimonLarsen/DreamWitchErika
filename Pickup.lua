local Entity = require("Entity")
local Animator = require("Animator")
local BoxCollider = require("BoxCollider")

local Pickup = class("Pickup", Entity)

function Pickup:initialize(x, y, prop, type)
	self.x, self.y = x, y+10
	self.z = 2
	self.name = "pickup"
	self.dir = tonumber(prop.dir)
	self.type = type

	self.taken = Preferences.static:get(self.type, false)
	self.animator = Animator(Resources.static:getAnimator("pickup.lua"))
	if self.taken == true then
		self.animator:setProperty("taken", true)
	else
		self.collider = BoxCollider(8, 8, 0, -14)
	end
end

function Pickup:update(dt)
	self.animator:update(dt)
end

function Pickup:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1, 20, 20)
end

function Pickup:onCollide(collider)
	if self.taken == false and collider.name == "player" then
		Preferences.static:set(self.type, true)
		self.animator:setProperty("taken", true)
		self.taken = true
		self.collider = nil
	end
end

return Pickup
