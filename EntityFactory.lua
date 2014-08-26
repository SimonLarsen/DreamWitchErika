local EntityFactory = class("EntityFactory")

local mapping = {
	sandblock = require("SandBlock"),
	block = require("Block"),

	spike = require("Spike"),
	slime = require("Slime"),
	knight = require("Knight"),
	wasp = require("Wasp"),

	pickup_djump = require("DoubleJumpPickup"),
	pickup_smash = require("SmashPickup"),
	pickup_dash = require("DashPickup"),
	pickup_superslash = require("SuperSlashPickup"),
	pickup_wjump = require("WallJumpPickup"),

	statue = require("Statue"),
	hourglass = require("Hourglass"),
}

function EntityFactory.static:create(type, ...)
	local constructor = mapping[type]
	assert(constructor ~= nil, "Couldn't find entity type: " .. type)
	return constructor(...)
end

return EntityFactory
