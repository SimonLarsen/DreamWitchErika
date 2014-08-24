local Entity = require("Entity")
local BoxCollider = require("BoxCollider")
local Animation = require("Animation")

local SandBlock = class("SandBlock", Entity)

function SandBlock:initialize(x, y)
	self.x, self.y = x, y
	self.z = 1
	self.name = "sandblock"
	self.collider = BoxCollider(20, 20)
	self.broken = 0

	self.anim = Animation(Resources.static:getImage("sandblock.png"), 20, 20, 0.08, false)
end

function SandBlock:update(dt)
	if self.broken > 0 then
		self.anim:update(dt)
		self.broken = self.broken + dt
		if self.broken >= 0.2 then
			self:kill()
		end
	end
end

function SandBlock:draw()
	self.anim:draw(self.x, self.y, 0, 1, 1, 10, 10)
end

function SandBlock:onCollide(collider)
	if collider.name == "superslash" then
		self.broken = 0.0001
	end
end

return SandBlock
