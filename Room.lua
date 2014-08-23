local Room = class("Room")

function Room:initialize(x, y, w, h, id)
	self.x, self.y = x, y
	self.w, self.h = w, h
	self.id = id
	self.tiles = {}
end

return Room
