local Entity = require("Entity")
local Animation = require("Animation")
local BoxCollider = require("BoxCollider")

local Spike = class("Spike", Entity)

function Spike:initialize(x, y)
	self.x, self.y = x, y
	self.z = 1
	self.name = "spike"
	self.collider = BoxCollider(5, 10)

	self.sprite = Resources.static:getImage("spike.png")
end

function Spike:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, 10, 10)
end

return Spike
