local CollisionHandler = class("CollisionHandler")

function CollisionHandler.static:checkAll(entities)
	for i=1, #entities do
		for j=i+1, #entities do
			local v = entities[i]
			local w = entities[j]
			if v.collider and w.collider then
				local collision
				if v.collider:getType() == "box" and w.collider:getType() == "box" then
					collision = self:checkBoxBox(v, w)
				end
				if collision == true then
					v:onCollide(w)
					w:onCollide(v)
				end
			end
		end
	end
end

function CollisionHandler.static:checkBoxBox(a, b)
	if math.abs(a.x - b.x) > (a.collider.w+b.collider.w)/2
	or math.abs(a.y - b.y) > (a.collider.h+b.collider.h)/2 then
		return false
	end

	return true
end

return CollisionHandler
