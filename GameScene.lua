local Scene = require("Scene")
local World = require("World")
local Player = require("Player")
local Minimap = require("Minimap")

local GameScene = class("GameScene", Scene)

function GameScene:enter()
	self.player = self:addEntity(Player())
	self.map = self:addEntity(World())
	self:addEntity(Minimap())
end

return GameScene
