local Scene = require("Scene")
local Player = require("Player")
local World = require("World")

local GameScene = class("GameScene", Scene)

function GameScene:enter()
	self.player = self:addEntity(Player())
	self.player.x = 160
	self.player.y = 90

	self.map = self:addEntity(World())
end

return GameScene
