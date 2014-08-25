local Entity = require("Entity")
local Animator = require("Animator")
local BoxCollider = require("BoxCollider")
local Orb = require("Orb")

local Wasp = class("Wasp", Entity)

Wasp.static.MOVE_SPEED = 100

function Wasp:initialize(x, y, prop)
	self.x, self.y = x, y
	self.z = 0
	self.name = "wasp"
	self.dir = tonumber(prop.dir)
	self.health = 1
	self.blink = 0
	
	self.collider = BoxCollider(16, 16)
	self.animator = Animator(Resources.static:getAnimator("wasp.lua"))
end

function Wasp:update(dt)
	if self.world == nil then
		self.world = self.scene:find("world")
	end

	if self.health > 0 then
		local oldx = self.x
		self.x = self.x + self.dir * Wasp.static.MOVE_SPEED * dt
		if self.world:collide(self.x-8, self.y-8, 16, 16) then
			self.x = oldx
			self.dir = -self.dir
		end
	else
		if self.blink <= 0 then
			self:kill()
		end
	end

	if self.blink > 0 then self.blink = self.blink - dt end

	self.animator:update(dt)
end

function Wasp:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
	if self.blink > 0 and math.cos(self.blink * 50) < 0 then
		love.graphics.setBlendMode("additive")
		self.animator:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
		love.graphics.setBlendMode("alpha")
	end
end

function Wasp:onCollide(collider)
	if self.blink > 0 then return end

	if collider.name == "slash" then
		self.blink = 0.5
		self.health = self.health - 0.5
	elseif collider.name == "superslash" then
		self.blink = 0.5
		self.health = 0
	end

	if self.health <= 0 then
		if math.random() < 0.333 then
			self.scene:addEntity(Orb(self.x, self.y))
		end
		Sound.play("die")
		self.animator:setProperty("die", true)
		self.collider = nil
	end
end

return Wasp
