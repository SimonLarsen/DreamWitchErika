local EntityFactory = class("EntityFactory")

local mapping = {
	sandblock = require("SandBlock"),

	spike = require("Spike"),
	slime = require("Slime"),
	knight = require("Knight"),
	wasp = require("Wasp"),

	pickup_djump = require("DoubleJumpPickup"),
}

function EntityFactory.static:create(type, ...)
	local constructor = mapping[type]
	assert(constructor ~= nil, "Couldn't find entity type: " .. type)
	return constructor(...)
end

return EntityFactory
