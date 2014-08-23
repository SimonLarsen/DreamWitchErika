local Entity = require("Entity")
local BBox = require("BBox")
local WorldData = require("WorldData")

local World = class("World", Entity)

function World:initialize()
	self.x, self.y, self.z = 0, 0, 100
	self.name = "world"

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
	self._room = self._worlddata:getRoom("tunnel")

	self:buildSpriteBatchs(self._room)
	self:buildCollisionBoxes(self._room)
end

function World:buildSpriteBatchs(room)
	self._fgbatch = love.graphics.newSpriteBatch(self._tileset, room.w*room.h)
	self._bgbatch = love.graphics.newSpriteBatch(self._tileset, room.w*room.h)

	for i, tile in ipairs(room.fgtiles) do
		local x = ((i - 1) % room.w) * TILEW
		local y = 0
		if i > 1 then
			y = math.floor((i-1) / room.w) * TILEW
		end
		if tile > 0 then
			self._fgbatch:add(self._quads[tile], x, y)
		end
	end

	for i, tile in ipairs(room.bgtiles) do
		local x = ((i - 1) % room.w) * TILEW
		local y = 0
		if i > 1 then
			y = math.floor((i-1) / room.w) * TILEW
		end
		if tile > 0 then
			self._bgbatch:add(self._quads[tile], x, y)
		end
	end
end

function World:buildCollisionBoxes(room)
	self._boxes = {}

	for i, tile in ipairs(room.fgtiles) do
		local x = ((i - 1) % room.w) * TILEW
		local y = 0
		if i > 1 then
			y = math.floor((i-1) / room.w) * TILEW
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

function World:getBoxes()
	return self._boxes
end

function World:getRoom()
	return self._room
end

return World
