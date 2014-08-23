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
	local ca = a.collider
	local cb = b.collider

	if a.x-ca.w/2 > b.x+cb.w/2
	or b.x-cb.w/2 > a.x+ca.w/2
	or a.y-ca.h/2 > b.y+cb.h/2
	or b.y-cb.h/2 > a.y+ca.h/2 then
		return false
	end
	return true
end

return CollisionHandler
