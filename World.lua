	local Entity = require("Entity")
	local BBox = require("BBox")
	local WorldData = require("WorldData")
	local Door = require("Door")
	local BlackDoor = require("BlackDoor")
	local Slime = require("slime")
	local SandBlock = require("SandBlock")
	local EntityFactory = require("EntityFactory")
	local Fade = require("Fade")

	local World = class("World", Entity)

	function World:initialize(spawn)
		self.x, self.y, self.z = 0, 0, 100
		self.name = "world"
		self._room = nil
		self.fading = false

		self._tileset = Resources.static:getImage("tiles.png")
		local imgw = self._tileset:getWidth()
		local imgh = self._tileset:getHeight()
		local xtiles = math.floor(imgw / TILEW)
		local ytiles = math.floor(imgh / TILEW)

	self._quads = {}
	for iy = 0, ytiles-1 do
		for ix = 0, xtiles-1 do
			local quad = love.graphics.newQuad(ix*TILEW, iy*TILEW, TILEW, TILEW, imgw, imgh)
			table.insert(self._quads, quad)
		end
	end

	self._worlddata = WorldData()
	self:spawnInRoom(spawn)
end

function World:goToRoom(id, door)
	if self.fading then return end
	self.scene:addEntity(Fade(Fade.static.TO_BLACK, 1))
	local player = self.scene:find("player")
	player.frozen = 1
	self.fading = true
	Timer.add(0.99, function()
		self:walkInRoom(id, door)
		self.scene:addEntity(Fade(Fade.static.FROM_BLACK, 1))
		self.fading = false
	end)
end

function World:spawnInRoom(id)
	local room, spawn
	for i,v in ipairs(self._worlddata:getSpawns()) do
		if v.id == id then
			room = v.room
			spawn = v
			break
		end
	end
	assert(spawn, "Spawn \""..spawn.id.." not found")
	assert(room, "Spawn room not found")
	self.scene = gamestate.current()
	self:loadRoom(room)

	local player = self.scene:find("player")
	player.x = spawn.x
	player.y = spawn.y
end

function World:walkInRoom(id, door)
	for i,v in ipairs(self.scene:getEntities()) do
		if v.name ~= "player" and v.name ~= "world" and v.name ~= "minimap" then
			v:kill()
		end
	end
	
	self:loadRoom(id)

	local player = self.scene:find("player")
	for i,v in ipairs(self._room.doors) do
		if v.id == door.id then
			if door.x == 0 then
				player.x = v.x - 10
				player.y = v.y+24
			else
				player.x = v.x + 10
				player.y = v.y+24
			end
		end
	end
end

function World:leaveWorld()
	if self.fading then return end

	self.scene:addEntity(Fade(Fade.static.TO_BLACK, 1))
	self.fading = true
	Timer.add(0.99, function()
		gamestate.switch(require("MeadowScene")())
	end)
end

function World:loadRoom(id)
	self._room = self._worlddata:getRoom(id)

	self:buildSpriteBatchs(self._room)
	self:buildCollisionBoxes(self._room)

	for i,v in ipairs(self._room.doors) do
		if v.black == true then
			self.scene:addEntity(BlackDoor(v.x, v.y, v.left, v.right, v.id))
		else
			self.scene:addEntity(Door(v.x, v.y, v.left, v.right, v.id))
		end
	end
	for i,v in ipairs(self._room.entities) do
		local e = EntityFactory.static:create(v.type, v.x+TILEW/2, v.y+TILEW/2, v.prop)
		self.scene:addEntity(e)
	end

	Preferences.static:set("room".. self._room.id, true)
end

function World:buildSpriteBatchs(room)
	self._fgbatch = love.graphics.newSpriteBatch(self._tileset, room.w*room.h)
	self._bgbatch = love.graphics.newSpriteBatch(self._tileset, room.w*room.h)

	local xtiles = room.w / TILEW
	for i, tile in ipairs(room.fgtiles) do
		local x = ((i - 1) % xtiles) * TILEW
		local y = 0
		if i > 1 then
			y = math.floor((i-1) / xtiles) * TILEW
		end
		if tile > 0 then
			self._fgbatch:add(self._quads[tile], x, y)
		end
	end

	for i, tile in ipairs(room.bgtiles) do
		local x = ((i - 1) % xtiles) * TILEW
		local y = 0
		if i > 1 then
			y = math.floor((i-1) / xtiles) * TILEW
		end
		if tile > 0 then
			self._bgbatch:add(self._quads[tile], x, y)
		end
	end
end

function World:buildCollisionBoxes(room)
	self._boxes = {}

	local xtiles = room.w / TILEW
	for i, tile in ipairs(room.fgtiles) do
		local x = ((i - 1) % xtiles) * TILEW
		local y = 0
		if i > 1 then
			y = math.floor((i-1) / xtiles) * TILEW
		end
		if tile > 0  then
			table.insert(self._boxes, BBox(x, y, TILEW, TILEW))
		end
	end
end

function World:update(dt)

end

function World:draw()
	love.graphics.draw(self._bgbatch, 0, 0)
	love.graphics.draw(self._fgbatch, 0, 0)
end

function World:collide(x, y, w, h)
	for i,v in ipairs(self._boxes) do
		if v:collide(x, y, w, h) then
			return true
		end
	end
	return false
end

function World:getBoxes()
	return self._boxes
end

function World:getRoom()
	return self._room
end

function World:getWorldData()
	return self._worlddata
end

return World
