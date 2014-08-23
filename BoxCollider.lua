local Collider = require("Collider")

local BoxCollider = class("BoxCollider", Collider)

function BoxCollider:initialize(w, h)
	self.w, self.h = w, h
end

function BoxCollider:getType() return "box" end

return BoxCollider
