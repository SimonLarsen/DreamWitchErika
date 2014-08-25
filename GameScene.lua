local Scene = require("Scene")
local World = require("World")
local Player = require("Player")
local Minimap = require("Minimap")
local Fade = require("Fade")

local GameScene = class("GameScene", Scene)

function GameScene:initialize(spawn)
	Scene.initialize(self)
	self.spawn = spawn or "start"
end

function GameScene:enter()
	self:addEntity(Player())
	self:addEntity(World(self.spawn))
	self:addEntity(Minimap())
	self:addEntity(Fade(Fade.static.FROM_BLACK, 1))
end

return GameScene
