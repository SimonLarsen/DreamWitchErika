local BoxCollider = require("BoxCollider")
local Pickup = require("Pickup")

local DoubleJumpPickup = class("DoubleJumpPickup", Pickup)

function DoubleJumpPickup:initialize(x, y, prop)
	Pickup.initialize(self, x, y, prop, "has_djump")
end

return DoubleJumpPickup
