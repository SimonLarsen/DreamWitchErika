local Collider = require("Collider")

local TilemapCollider = class("TilemapCollider", Collider)

function TilemapCollider:initialize()
	self._boxes = {}
end

function TilemapCollider:addBox(b)
	table.insert(self._boxes, b)
end

function TilemapCollider:getBoxes()
	return self._boxes
end

function TilemapCollider:getType() return "tilemap" end

return TilemapCollider
