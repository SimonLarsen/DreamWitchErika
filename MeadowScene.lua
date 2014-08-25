local Scene = require("Scene")
local Sprite = require("Sprite")
local NPC = require("NPC")
local MeadowPlayer = require("MeadowPlayer")
local MeadowPrompt = require("MeadowPrompt")
local SleepZ = require("SleepZ")

local MeadowScene = class("MeadowScene", Scene)

function MeadowScene:enter()
	Camera.static:setPosition(WIDTH/2, HEIGHT/2)
	self:addEntity(Sprite(WIDTH/2, HEIGHT/2, 100, Resources.static:getImage("meadow.png")))
	self:addEntity(MeadowPlayer(44, 100))
	self:addEntity(MeadowPrompt())

	self:addEntity(NPC(95, 130, 1, 20, 20))
	self:addEntity(NPC(135, 130, 2, 20, 20))
	self:addEntity(NPC(175, 128.5, 3, 13, 21))
	self:addEntity(NPC(215, 130, 4, 20, 20))
	self:addEntity(NPC(255, 127.5, 5, 22, 23))

	self:addEntity(SleepZ(95, 110))
	self:addEntity(SleepZ(135, 110))
	self:addEntity(SleepZ(175, 110))
	self:addEntity(SleepZ(215, 110))
	self:addEntity(SleepZ(255, 110))
end

return MeadowScene
