local Entity = require("Entity")
local Animation = require("Animation")

local MeadowPrompt = class("MeadowPrompt", Entity)

function MeadowPrompt:initialize()
	self.x, self.y = 0, 100
	self.z = 0
	self.name = "meadowprompt"

	self.alpha = 0

	self.anim = Animation(Resources.static:getImage("meadowprompt.png"), 40, 40, 0.2)
end

function MeadowPrompt:update(dt)
	self.anim:update(dt)
	self.alpha = math.max(0, self.alpha - 600*dt)
end

function MeadowPrompt:draw()
	love.graphics.setColor(255, 255, 255, self.alpha)
	self.anim:draw(self.x, self.y, 0, 1, 1, 20, 20)
	love.graphics.setColor(255, 255, 255, 255)
end

return MeadowPrompt
