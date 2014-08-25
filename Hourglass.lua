local Entity = require("Entity")
local BoxCollider = require("BoxCollider")

local Hourglass = class("Hourglass", Entity)

function Hourglass:initialize(x, y, prop)
	self.x, self.y = x, y
	self.z = 1

	self.id = prop.id
	self.taken = Preferences.static:get(self.id, false)
	if self.taken == false then
		self.collider = BoxCollider(16, 16)
		self.sprite = Resources.static:getImage("hourglass.png")
	end
end

function Hourglass:update(dt)
	
end

function Hourglass:draw()
	if self.taken == false then
		love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, 10, 10)
	end
end

function Hourglass:onCollide(collider)
	if collider.name == "player" then
		self.taken = true
		Preferences.static:set(self.id, true)
		self.collider = nil
		Sound.play("powerup")
		local hourglasses = Preferences.static:get("hourglasses", 0)
		hourglasses = hourglasses + 1
		Preferences.static:set("hourglasses", hourglasses)
	end
end

return Hourglass
