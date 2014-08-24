local Entity = require("Entity")
local Animation = require("Animation")
local BoxCollider = require("BoxCollider")

local SuperSlash = class("SuperSlash", Entity)

function SuperSlash:initialize(x, y, dir, xspeed)
	self.x, self.y, self.z = x, y, -1
	self.xspeed = xspeed or 0
	self.dir = dir
	self.time = 0
	self.name = "superslash"
	self.collider = BoxCollider(28, 32)

	local sprite = Resources.static:getImage("superslash.png")
	self.anim = Animation(sprite, 32, 32, 0.0667, 14, 16)
end

function SuperSlash:update(dt)
	self.time = self.time + dt
	self.x = self.x + self.xspeed * dt

	self.anim:update(dt)

	if self.time > 0.2 then
		self:kill()
	end
end

function SuperSlash:draw()
	self.anim:draw(self.x, self.y, 0, self.dir, 1, 14, 16)
end

return SuperSlash
