local BoxCollider = require("BoxCollider")
local Pickup = require("Pickup")

local SmashPickup = class("SmashPickup", Pickup)

function SmashPickup:initialize(x, y, prop)
	Pickup.initialize(self, x, y, prop)
	self.taken = Preferences.static:get("has_smash", false)
end

function SmashPickup:onCollide(collider)
	if self.taken == false and collider.name == "player" then
		Preferences.static:set("has_smash", true)
		self.animator:setProperty("taken", true)
		self.taken = true
		self.collider = nil
	end
end

return SmashPickup
