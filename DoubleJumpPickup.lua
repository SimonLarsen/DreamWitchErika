local BoxCollider = require("BoxCollider")
local Pickup = require("Pickup")

local DoubleJumpPickup = class("DoubleJumpPickup", Pickup)

function DoubleJumpPickup:initialize(x, y, prop)
	Pickup.initialize(self, x, y, prop)
	self.taken = Preferences.static:get("has_djump", false)
end

function DoubleJumpPickup:onCollide(collider)
	if self.taken == false and collider.name == "player" then
		Preferences.static:set("has_djump", true)
		self.animator:setProperty("taken", true)
		self.taken = true
		self.collider = nil
	end
end

return DoubleJumpPickup
