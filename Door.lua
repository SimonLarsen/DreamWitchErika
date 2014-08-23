local Entity = require("Entity")
local BoxCollider = require("BoxCollider")

local Door = class("Door", Entity)

function Door:initialize(x, y, left, right, id)
	self.x, self.y = x, y
	self.z = 1
	self.left, self.right = left, right
	self.name = "door"
	self.id = id

	self.collider = BoxCollider(10, 40)
	self.sprite = Resources.static:getImage("door.png")
end

function Door:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, 20, 20)
end

function Door:onCollide(collider)
	if collider.name == "player" then
		local world = self.scene:find("world")
		local player = self.scene:find("player")
		if world:getRoom().id == self.left then
			world:walkInRoom(self.right, self)
		else
			world:walkInRoom(self.left, self)
		end
	end
end

return Door
