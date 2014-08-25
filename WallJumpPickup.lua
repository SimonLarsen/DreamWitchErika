local Pickup = require("Pickup")

local WallJumpPickup = class("WallJumpPickup", Pickup)

function WallJumpPickup:initialize(x, y, prop)
	Pickup.initialize(self, x, y, prop, "has_wjump")
end

return WallJumpPickup
