local Entity = require("Entity")
local BoxCollider = require("BoxCollider")
local Explosion = require("Explosion")

local Statue = class("Statue", Entity)

function Statue:initialize(x, y, prop)
	self.x, self.y = x, y
	self.z = 2

	self.id = tonumber(prop.id)
	self.clear = Preferences.static:get("clear"..self.id, false)
	if self.clear then
		self.sprite = Resources.static:getImage("statuebroken.png")
	else
		self.sprite = Resources.static:getImage("statue"..self.id..".png")
		self.collider = BoxCollider(10, 10)
	end
end

function Statue:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, 11, 15)
end

function Statue:onCollide(collider)
	if collider.name == "slash" or collider.name == "superslash" then
		Preferences.static:set("clear"..self.id, true)
		self.collider = nil
		self.scene:addEntity(Explosion(self.x, self.y))
		Timer.add(1.6, function()
			self.sprite = Resources.static:getImage("statuebroken.png")
		end)
		Timer.add(2.1, function()
			self.scene:find("world"):leaveWorld()
		end)
	end
end

return Statue
