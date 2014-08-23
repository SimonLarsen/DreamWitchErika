local BBox = class("BBox")

function BBox:initialize(x, y, w, h)
	self.x, self.y = x, y
	self.w, self.h = w, h
end

function BBox:collide(x, y, w, h)
	if x > self.x+self.w or self.x > x+w
	or y > self.y+self.h or self.y > y+h then
		return false
	else
		return true
	end
end

return BBox
