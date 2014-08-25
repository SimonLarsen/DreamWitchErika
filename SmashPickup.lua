local Pickup = require("Pickup")

local SmashPickup = class("SmashPickup", Pickup)

function SmashPickup:initialize(x, y, prop)
	Pickup.initialize(self, x, y, prop, "has_smash")
end

return SmashPickup
