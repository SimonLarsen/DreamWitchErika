local Scene = require("Scene")
local World = require("World")
local Player = require("Player")

local GameScene = class("GameScene", Scene)

function GameScene:enter()
	self.player = self:addEntity(Player())
	self.map = self:addEntity(World())
end

return GameScene
