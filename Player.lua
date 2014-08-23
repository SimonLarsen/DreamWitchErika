local Entity = require("Entity")
local BoxCollider = require("BoxCollider")
local Animator = require("Animator")

local Player = class("Player", Entity)

Player.static.MOVE_SPEED = 100
Player.static.GRAVITY = 600
Player.static.JUMP_POWER = 230
Player.static.MAX_SPEED = 200

function Player:initialize()
	self.x, self.y, self.z = 0, 0, 0
	self.xspeed = 0
	self.yspeed = 0
	self.dir = 1
	self.name = "player"
	self.grounded = false

	self.collider = BoxCollider(8, 20)
	self.animator = Animator(Resources.static:getAnimator("player.lua"))
end

function Player:update(dt)
	if self.world == nil then
		self.world = self.scene:find("world")
	end

	local state = 0
	self.xspeed = 0
	if Input.static:isDown("left") then
		self.xspeed = -Player.static.MOVE_SPEED
		self.dir = -1
		state = 1
	end
	if Input.static:isDown("right") then
		self.xspeed = Player.static.MOVE_SPEED
		self.dir = 1
		state = 1
	end
	self.animator:setProperty("state", state)

	if Input.static:wasPressed("up") and self.grounded then
		self.yspeed = -Player.static.JUMP_POWER
	end

	local oldx = self.x
	self.x = self.x + self.xspeed * dt
	for i,v in ipairs(self.world:getBoxes()) do
		if v:collide(self.x-4, self.y-10, 8, 20) then
			self.x = oldx
		end
	end

	self.yspeed = self.yspeed + Player.static.GRAVITY*dt
	self.yspeed = math.min(self.yspeed, Player.static.MAX_SPEED)
	local oldy = self.y
	self.y = self.y + self.yspeed * dt
	self.grounded = false
	for i,v in ipairs(self.world:getBoxes()) do
		if v:collide(self.x-4, self.y-10, 8, 20) then
			self.grounded = true
			self.y = oldy
			self.yspeed = self.yspeed/2
		end
	end

	self.animator:update(dt)
	Camera.static:setPosition(self.x, self.y)
end

function Player:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1)
end

return Player
