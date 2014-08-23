local Collider = require("Collider")

local CompositeCollider("CompositeCollider"), Collider)

function CompositeCollider:initialize()
	self._colliders = {}
end

function CompositeCollider:addCollider(c)
	table.insert(self._colliders, c)
end

function CompositeCollider:getColliders()
	return self._colliders
end

return CompositeCollider
