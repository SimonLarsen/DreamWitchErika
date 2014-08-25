local Entity = require("Entity")
local Animator = require("Animator")
local BoxCollider = require("BoxCollider")

local Knight = class("Knight", Entity)

Knight.static.GRAVITY = 600
Knight.static.DASH_SPEED = 300
Knight.static.MAX_JUMP = 250
Knight.static.MIN_JUMP = 100
Knight.static.RANGE = 100
Knight.static.JUMP_RANGE = 50
Knight.static.COOLDOWN = 1.5

function Knight:initialize(x, y, prop)
	self.x, self.y = x, y-0.01
	self.xspeed, self.yspeed = 0, 0
	self.z = 0
	self.name = "knight"
	self.dir = tonumber(prop.dir)
	self.state = 0
	self.grounded = false
	self.cooldown = 0
	self.health = 1
	self.blink = 0

	self.collider = BoxCollider(16, 20)
	self.animator = Animator(Resources.static:getAnimator("knight.lua"))
end

function Knight:update(dt)
	if self.world == nil then
		self.world = self.scene:find("world")
	end
	if self.player == nil then
		self.player = self.scene:find("player")
	end

	local ddir = math.sign(self.player.x - self.x)
	local dist = math.abs(self.player.x - self.x)

	if self.cooldown > 0 then self.cooldown = self.cooldown - dt end
	if self.blink > 0 then self.blink = self.blink - dt end
	if self.health <= 0 and self.blink <= 0 then
		self:kill()
	end

	if self.state == 0 then -- idle 
		if dist < Knight.static.RANGE
		and ddir == self.dir and self.player.y < self.y+5 then
			self.state = 1
			self.animator:setProperty("state", 1)
		end
	elseif self.state == 1 then -- run
		self.yspeed = 0
		self.xspeed = Knight.static.DASH_SPEED * self.dir
		if dist < Knight.static.JUMP_RANGE and self.player.y < self.y-1 then
			self.state = 2
			self.animator:setProperty("jump", true)
			if self.player.y < self.y then
				self.yspeed = -math.max(Knight.static.MIN_JUMP, math.min((self.y - self.player.y) * 10, Knight.static.MAX_JUMP))
			end
		end
		if ddir ~= self.dir then
			self.state = 3
			self.animator:setProperty("state", 3)
			self.animator:setProperty("land", true)
			self.cooldown = Knight.static.COOLDOWN
		end

	elseif self.state == 2 then -- jump
		if self.yspeed < 0 then
			self.xspeed = -self.yspeed * self.dir
		else
			self.xspeed = 0
		end
		if self.grounded == true then
			self.state = 3
			self.animator:setProperty("state", 3)
			self.animator:setProperty("land", true)
			self.cooldown = Knight.static.COOLDOWN
		end

	elseif self.state == 3 then -- cooldown
		self.xspeed = 0
		if self.cooldown <= 0 then
			self.state = 0
			self.animator:setProperty("state", 0)
			self.dir = ddir
		end
	end

	self.yspeed = self.yspeed + Knight.static.GRAVITY*dt
	local oldy = self.y
	self.y = self.y + self.yspeed * dt
	self.grounded = false
	if self.world:collide(self.x-5, self.y - 10, 10, 20) then
		self.y = oldy
		self.yspeed = self.yspeed / 2
		self.grounded = true
	end

	local oldx = self.x
	self.x = self.x + self.xspeed*dt
	if self.world:collide(self.x-5, self.y - 10, 10, 20) then
		self.x = oldx
	end

	self.animator:update(dt)
end

function Knight:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
	if self.blink > 0 and math.cos(self.blink * 50) < 0 then
		love.graphics.setBlendMode("additive")
		self.animator:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
		love.graphics.setBlendMode("alpha")
	end
end

function Knight:onCollide(collider)
	if self.blink > 0 then return end
	if collider.name == "slash" then
		self.cooldown = 1
		self.blink = 0.5
		self.health = self.health - 0.34
	elseif collider.name == "superslash" then
		self.cooldown = 1
		self.blink = 0.5
		self.health = self.health - 0.5
	elseif collider.name == "spike" then
		self.cooldown = 1
		self.blink = 0.5
		self.health = 0
		self.animator:setProperty("die", true)
	end
	if self.health <= 0 then
		self.animator:setProperty("die", true)
		self.name = ""
	end
end

return Knight
