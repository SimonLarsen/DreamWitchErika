local Entity = require("Entity")
local BoxCollider = require("BoxCollider")
local Animator = require("Animator")
local Slash = require("Slash")
local SuperSlash = require("SuperSlash")
local CollisionHandler = require("CollisionHandler")

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
	self.slash = 0
	self.djumped = true

	self.collider = BoxCollider(8, 20)
	self.animator = Animator(Resources.static:getAnimator("player.lua"))
end

function Player:update(dt)
	if self.world == nil then
		self.world = self.scene:find("world")
	end

	local state = 0
	-- Update physics / collisions
	self.oldx = self.x
	self.x = math.min(self.world:getRoom().w-5, math.max(5, self.x + self.xspeed * dt))
	if self.world:collide(self.x-4, self.y-7, 8, 17) then
		self.x = self.oldx
	end

	self.yspeed = self.yspeed + Player.static.GRAVITY*dt
	self.yspeed = math.min(self.yspeed, Player.static.MAX_SPEED)
	self.oldy = self.y
	self.y = self.y + self.yspeed * dt
	self.grounded = false
	if self.world:collide(self.x-4, self.y-7, 8, 17) then
		self.grounded = true
		if Preferences.static:get("has_djump") == true then
			self.djumped = false
		end
		self.y = self.oldy
		self.yspeed = self.yspeed/2
	end

	-- Move
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

	-- Jump
	if Input.static:wasPressed("up")
	and (self.grounded == true or self.djumped == false) then
		if self.grounded == false then
			self.djumped = true
		end
		self.yspeed = -Player.static.JUMP_POWER
		self.animator:setProperty("jump", true)
	end

	-- Slash
	if self.slash > 0 then
		self.slash = self.slash - dt
		if self.slash <= 0 then
			local slash
			if Preferences.static:get("has_superslash") == true then
				slash = SuperSlash(self.x+self.dir*16, self.y, self.dir, self.xspeed)
			else
				slash = Slash(self.x+self.dir*12, self.y, self.dir, self.xspeed)
			end
			self.scene:addEntity(slash)
		end
	end

	if Input.static:wasPressed(" ") and self.slash <= 0 then
		self.slash = 0.3
		self.animator:setProperty("swing", true)
	end

	if self.grounded == false then
		state = 2
	end
	self.animator:setProperty("state", state)
	self.animator:update(dt)

	local room = self.world:getRoom()
	local camx = math.min(room.w-WIDTH/2, math.max(WIDTH/2, self.x))
	local camy = math.min(room.h-HEIGHT/2, math.max(HEIGHT/2, self.y))
	Camera.static:setPosition(camx, camy)
end

function Player:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1)
end

function Player:onCollide(collider)
	if collider.name == "sandblock" then
		if CollisionHandler.static:checkBoxBox(self, collider) then
			self.x = self.oldx
		end
	end
end

return Player
