local CollisionHandler = class("CollisionHandler")

function CollisionHandler.static:CheckAll(entities)
	for i,v in ipairs(entities) do
		for j, w in ipairs(entities) do
			if v.collider and w.collider then
				local collision
				if v.collider:getType() == "box" and w.collider:getType() == "box" then
					collision = self.static:CheckBoxBox(v, w)
				end
				if collision == true then
					v:onCollide(w)
					w:onCollide(v)
				end
			end
		end
	end
end

function CollisionHandler.static:CheckBoxBox(a, b)
	local ca = a.collider
	local cb = b.collider

	if math.abs(a.x - b.x) > (ca.w+cb.w)/2
	or math.abs(a.y - b.y) > (ca.h+cb.h)/2 then
		return false
	else
		return true
	end
end

return CollisionHandler
