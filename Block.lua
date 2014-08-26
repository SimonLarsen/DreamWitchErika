local Entity = require("Entity")
local BoxCollider = require("BoxCollider")
local Animation = require("Animation")

local Block = class("Block", Entity)

function Block:initialize(x, y, prop)
	self.x, self.y = x,y
	self.z = -1
	self.name = "block"
	self.collider = BoxCollider(20, 20)
	self.broken = 0

	self.anim = Animation(Resources.static:getImage("fakeblock.png"), 20, 20, 0.1, false)
end

function Block:update(dt)
	if self.broken > 0 then
		self.anim:update(dt)
		self.broken = self.broken + dt
		if self.broken >= 0.5 then
			self:kill()
		end
	end
end
function Block:draw()
	self.anim:draw(self.x, self.y, 0, 1, 1, 10, 10)
end

function Block:onCollide(collider)
	if collider.name == "slash" or collider.name == "superslash" then
		if self.broken == 0 then
			self.broken = 0.0001
			self.collider = nil
			Sound.play("smash")
		end
	end
end

return Block
