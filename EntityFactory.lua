local EntityFactory = class("EntityFactory")

local mapping = {
	slime = require("Slime"),
	sandblock = require("SandBlock"),
	spike = require("Spike"),
	pickup_djump = require("DoubleJumpPickup"),
}

function EntityFactory.static:create(type, ...)
	local constructor = mapping[type]
	assert(constructor ~= nil, "Couldn't find entity type: " .. type)
	return constructor(...)
end

return EntityFactory
