local Scene = class("Scene")

function Scene:initialize()
	self._entities = {}
end

function Scene:update(dt)
	-- Update entities
	for i, v in ipairs(self._entities) do
		v:update(dt)
	end
	-- Delete dead entities
	for i=#self._entities, 1, -1 do
		if self._entities[i]:isAlive() == false then
			table.remove(self._entities, i)
		end
	end
end

function Scene:draw()
	for i,v in ipairs(self._entities) do
		v:draw()
	end
end

function Scene:addEntity(e)
	table.insert(self._entities, e)
	table.sort(self._entities, function(a,b)
		return a.z > b.z
	end)
	e.scene = self
	return e
end

function Scene:find(name)
	for i,v in ipairs(self._entities) do
		if v.name == name then
			return v
		end
	end
	return nil
end

return Scene
