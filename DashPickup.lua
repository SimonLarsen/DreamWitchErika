local Pickup = require("Pickup")

local DashPickup = class("DashPickup", Pickup)

function DashPickup:initialize(x, y, prop)
	Pickup.initialize(self, x, y, prop, "has_dash")
end

return DashPickup
