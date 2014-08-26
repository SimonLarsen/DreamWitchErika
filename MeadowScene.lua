local Scene = require("Scene")
local Sprite = require("Sprite")
local NPC = require("NPC")
local MeadowPlayer = require("MeadowPlayer")
local MeadowPrompt = require("MeadowPrompt")
local SleepZ = require("SleepZ")

local MeadowScene = class("MeadowScene", Scene)

function MeadowScene:initialize(title)
	Scene.initialize(self)
	self.title = title or false
end

function MeadowScene:enter()
	if self.title then
		Camera.static:setPosition(WIDTH/2, -HEIGHT/2)
	else
		Camera.static:setPosition(WIDTH/2, HEIGHT/2)
	end
	self:addEntity(Sprite(WIDTH/2, 0, 100, Resources.static:getImage("meadow2.png")))
	self:addEntity(MeadowPlayer(44, 100))
	self:addEntity(MeadowPrompt())

	self:addEntity(NPC(95, 130, 1, 20, 20))
	self:addEntity(NPC(135, 130, 2, 20, 20))
	self:addEntity(NPC(175, 129, 3, 13, 22))
	self:addEntity(NPC(215, 130, 4, 20, 20))
	self:addEntity(NPC(255, 128, 5, 22, 24))

	self:addEntity(SleepZ(95, 110))
	self:addEntity(SleepZ(135, 110))
	self:addEntity(SleepZ(175, 110))
	self:addEntity(SleepZ(215, 110))
	self:addEntity(SleepZ(255, 110))

	local checkmark = Resources.static:getImage("checkmark.png")
	local allclear = true
	for i=1, 5 do
		if Preferences.static:get("clear" .. i, false) then
			self:addEntity(Sprite(55+i*40, 153, -1, checkmark))
		else
			allclear = false
		end
	end
	
	if allclear then
		self:addEntity(Sprite(WIDTH/2, 28, -2, Resources.static:getImage("congratulations.png")))
	end
end

return MeadowScene
