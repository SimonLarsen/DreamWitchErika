local Entity = require("Entity")

local Minimap = class("Minimap", Entity)

local scale = 1/16

function Minimap:initialize()
	self.x, self.y, self.z = 0, 0, -100
	self.name = "minimap"

	self.enabled = false
end

function Minimap:update(dt)
	if self.world == nil then
		self.world = self.scene:find("world")
		self.worlddata = self.world:getWorldData()
	end

	if Input.static:wasPressed("tab") then
		self.enabled = not self.enabled
	end
end

function Minimap:gui()
	if self.worlddata == nil or self.enabled == false then return end

	love.graphics.setColor(90, 183, 92, 128)
	local room = self.world:getRoom()
	love.graphics.rectangle("fill", 60+room.x*scale, room.y*scale, room.w*scale, room.h*scale)

	love.graphics.setColor(255, 255, 255)
	for i, room in ipairs(self.worlddata:getRooms()) do
		if Preferences.static:get(room.id, false) then
			love.graphics.rectangle("line", 60+room.x*scale, room.y*scale, room.w*scale, room.h*scale)
		end
	end

	love.graphics.setColor(255,255,255)
end

return Minimap
