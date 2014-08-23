local Collider = require("Collider")

local BoxCollider = class("BoxCollider", Collider)

function BoxCollider:initialize(w, h, ox, oy)
	self.w, self.h = w, h
	self.ox = ox or 0
	self.oy = oy or 0
end

function BoxCollider:getType() return "box" end

return BoxCollider
