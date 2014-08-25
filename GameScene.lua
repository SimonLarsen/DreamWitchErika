local Scene = require("Scene")
local World = require("World")
local Player = require("Player")
local Minimap = require("Minimap")

local GameScene = class("GameScene", Scene)

function GameScene:initialize(spawn)
	Scene.initialize(self)
	self.spawn = spawn or "start"
end

function GameScene:enter()
	self.player = self:addEntity(Player())
	self.map = self:addEntity(World(self.spawn))
	self:addEntity(Minimap())
end

return GameScene
