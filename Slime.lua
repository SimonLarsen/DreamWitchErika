local Entity = require("Entity")
local Animator = require("Animator")
local BoxCollider = require("BoxCollider")
local Orb = require("Orb")

local Slime = class("Slime", Entity)

Slime.static.GRAVITY = 600
Slime.static.JUMP_POWER_X = 100
Slime.static.JUMP_POWER_Y = 100

function Slime:initialize(x, y)
	self.x, self.y = x, y-1
	self.z = 0
	self.name = "slime"
	self.dir = dir
	self.grounded = true
	self.cooldown = 0
	self.health = 1
	self.collider = BoxCollider(16, 14, 0, 6)
	self.blink = 0

	self.xspeed, self.yspeed = 0, 0

	self.animator = Animator(Resources.static:getAnimator("slime.lua"))
	self.world = nil
	self.player = nil
end

function Slime:update(dt)
	if self.world == nil then
		self.world = self.scene:find("world")
	end
	if self.player == nil then
		self.player = self.scene:find("player")
	end

	if self.blink > 0 then self.blink = self.blink - dt end

	if self.health <= 0 and self.blink <= 0 then
		self:kill()
	end

	if self.cooldown > 0 then self.cooldown = self.cooldown - dt end

	if math.abs(self.y-self.player.y) < 20 and math.abs(self.x-self.player.x) < 100
	and self.grounded and self.cooldown <= 0 then
		self.dir = math.sign(self.player.x - self.x)
		self.xspeed = Slime.static.JUMP_POWER_X*self.dir
		self.yspeed = -Slime.static.JUMP_POWER_Y
		self.cooldown = 1
	end

	local oldx = self.x
	self.x = self.x + self.xspeed*dt
	if self.world:collide(self.x-8, self.y - 10, 16, 20) then
		self.x = oldx
		self.xspeed = -self.xspeed
	end

	self.yspeed = self.yspeed + Slime.static.GRAVITY*dt
	local oldy = self.y
	self.y = self.y + self.yspeed * dt
	self.grounded = false
	if self.world:collide(self.x-8, self.y - 10, 16, 20) then
		self.y = oldy
		self.yspeed = self.yspeed / 2
		self.xspeed = 0
		self.grounded = true
	end

	self.animator:update(dt)
end

function Slime:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
	if self.blink > 0 and math.cos(self.blink * 50) < 0 then
		love.graphics.setBlendMode("additive")
		self.animator:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
		love.graphics.setBlendMode("alpha")
	end
end

function Slime:onCollide(collider)
	if self.blink > 0 then return end
	if collider.name == "slash" then
		self.cooldown = 1
		self.blink = 0.5
		self.health = self.health - 0.5
	elseif collider.name == "superslash" then
		self.cooldown = 1
		self.blink = 0.5
		self.health = 0
	elseif collider.name == "spike" then
		self.cooldown = 1
		self.blink = 0.5
		self.health = 0
		self.animator:setProperty("die", true)
	end
	if self.health <= 0 then
		if math.random() < 0.1 then
			self.scene:addEntity(Orb(self.x, self.y))
		end
		self.animator:setProperty("die", true)
		self.collider = nil
		Sound.play("die")
	end
end

return Slime
