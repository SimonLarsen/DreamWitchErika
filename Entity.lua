local Entity = class("Entity")

function Entity:enter()
	self.x, self.y, self.z = 0, 0, 0

	self._alive = true
end

function Entity:update(dt)
	
end

function Entity:draw()
	
end

function Entity:gui()
	
end

function Entity:onCollide(collider)
	
end

function Entity:kill()
	self._alive = false
end

function Entity:isAlive()
	return self._alive
end

return Entity
