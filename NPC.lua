local Entity = require("Entity")
local Animation = require("Animation")
local BoxCollider = require("BoxCollider")

local NPC = class("NPC", Entity)

function NPC:initialize(x, y, id, fw, fh)
	self.x, self.y = x, y
	self.z = 1
	self.id = id
	self.name = "npc"
	self.collider = BoxCollider(16, 20)
	local image = Resources.static:getImage("npc"..id..".png")
	self.anim = Animation(image, fw, fh, 0.4)
	self.ox = image:getWidth()/2
	self.oy = image:getHeight()/2
end

function NPC:update(dt)
	self.anim:update(dt * (math.gauss()/2+1))
end

function NPC:draw()
	self.anim:draw(self.x, self.y, 0, 1, 1, self.ox, self.y)
end

function NPC:getSpawn()
	return tostring(self.id)
end

return NPC
