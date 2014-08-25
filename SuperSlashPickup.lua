local Pickup = require("Pickup")

local SuperSlashPickup = class("SuperSlashPickup", Pickup)

function SuperSlashPickup:initialize(x, y, prop)
	Pickup.initialize(self, x, y, prop, "has_superslash")
end

return SuperSlashPickup
