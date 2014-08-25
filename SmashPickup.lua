local Animation = require("Animation")
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
		self.anim._image = Resources.static:getImage("pickup_taken.png")
		self.taken = true
		self.collider = nil
	end
end

return SmashPickup
