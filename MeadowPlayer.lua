local Entity = require("Entity")
local Animator = require("Animator")
local Player = require("Player")
local BoxCollider = require("BoxCollider")
local Fade = require("Fade")

local MeadowPlayer = class("MeadowPlayer", Entity)

function MeadowPlayer:initialize(x, y)
	self.x, self.y = x, y
	self.z = 0
	self.dir = 1
	self.xspeed, self.yspeed = 0, 0
	self.grounded = false
	self.collider = BoxCollider(16, 20)

	self.animator = Animator(Resources.static:getAnimator("player.lua"))

	Sound.music("title")
end

function MeadowPlayer:update(dt)
	local state = 0

	if self.prompt == nil then
		self.prompt = self.scene:find("meadowprompt")
	end

	self.xspeed = 0
	if Input.static:isDown("a") then
		self.xspeed = -Player.static.MOVE_SPEED
		self.dir = -1
		state = 1
	end
	if Input.static:isDown("d") then
		self.xspeed = Player.static.MOVE_SPEED
		self.dir = 1
		state = 1
	end

	if Input.static:wasPressed("w") or Input.static:wasPressed("k") then
		if self.grounded == true then
			self.yspeed = -Player.static.JUMP_POWER
			self.animator:setProperty("jump", true)
			Sound.play("jump")
		end
	end

	self.x = self.x + self.xspeed * dt
	if self.x < 0 then self.x = 10 end
	if self.x > WIDTH-10 then self.x = WIDTH-10 end

	self.yspeed = self.yspeed + Player.static.GRAVITY*dt
	self.y = self.y + self.yspeed * dt
	self.grounded = false
	if self.y > 130 then
		self.y = 130
		self.grounded = true
		self.yspeed = 0
	end
	
	if self.grounded == false then
		state = 2
	end

	self.animator:setProperty("state", state)
	self.animator:update(dt)
end

function MeadowPlayer:draw()
	self.animator:draw(self.x, self.y, 0, self.dir, 1, 10, 10)
end

function MeadowPlayer:onCollide(collider)
	if collider.name == "npc" then
		self.prompt.x = collider.x-5
		self.prompt.alpha = 255
		if Input.static:wasPressed("j") then
			Sound.play("door")
			self.scene:addEntity(Fade(Fade.static.TO_BLACK, 1))
			Timer.add(0.99, function()
				gamestate.switch(require("GameScene")(collider:getSpawn()))
			end)
		end
	end
end

return MeadowPlayer
