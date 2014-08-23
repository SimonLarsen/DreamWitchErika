local Scene = require("Scene")
local World = require("World")
local Player = require("Player")

local GameScene = class("GameScene", Scene)

function GameScene:enter()
	self.player = self:addEntity(Player())
	self.player.x = 32
	self.player.y = 32

	self.map = self:addEntity(World())
end

return GameScene
