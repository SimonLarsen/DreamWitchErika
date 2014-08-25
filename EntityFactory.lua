local EntityFactory = class("EntityFactory")

local mapping = {
	sandblock = require("SandBlock"),

	spike = require("Spike"),
	slime = require("Slime"),
	knight = require("Knight"),
	wasp = require("Wasp"),

	pickup_djump = require("DoubleJumpPickup"),
	pickup_smash = require("SmashPickup"),
	pickup_dash = require("DashPickup"),
	pickup_superslash = require("SuperSlash"),
	pickup_wwjump = require("WallJumpPickup"),

	statue = require("Statue"),
	hourglass = require("hourglass"),
}

function EntityFactory.static:create(type, ...)
	local constructor = mapping[type]
	assert(constructor ~= nil, "Couldn't find entity type: " .. type)
	return constructor(...)
end

return EntityFactory
