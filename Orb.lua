local Entity = require("Entity")
local BoxCollider = require("BoxCollider")

local Orb = class("Orb", Entity)

function Orb:initialize(x, y, prop)
	self.x, self.y = x, y
	self.z = 1

	self.name = "orb"
	self.collider = BoxCollider(5, 5)

	self.sprite = Resources.static:getImage("orb.png")
	print("ORB CREATED")
end

function Orb:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, 2, 2)
end

function Orb:onCollide(collider)
	if collider.name == "player" then
		self.collider = nil
		self:kill()
	end
end

return Orb
