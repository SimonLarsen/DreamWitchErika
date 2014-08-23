local Entity = require("Entity")
local BBox = require("BBox")

local World = class("World", Entity)

function World:initialize()
	self.x, self.y, self.z = 0, 0, 100
	self.name = "world"

	local chunk = love.filesystem.load("data/maps/test.lua")
	local data = chunk()

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

	self._boxes = {}
	self._spritebatch = love.graphics.newSpriteBatch(self._tileset, 512)
	for i, layer in ipairs(data.layers) do
		if layer.name == "Tiles" then
			for j, tile in ipairs(layer.data) do
				local x = ((j - 1) % layer.width) * TILEW
				local y = 0
				if j > 1 then
					y = math.floor((j-1) / layer.width) * TILEW
				end
				self._spritebatch:add(self._quads[tile], x, y)
				if tile > 1 then
					table.insert(self._boxes, BBox(x, y, TILEW, TILEW))
				end
			end
		end
	end
end

function World:update(dt)
	
end

function World:draw()
	love.graphics.draw(self._spritebatch, 0, 0)
end

function World:getBoxes()
	return self._boxes
end

return World
