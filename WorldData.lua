local Room = require("Room")

local WorldData = class("WorldData")

function WorldData:initialize()
	local chunk = love.filesystem.load("data/maps/test.lua")
	local data = chunk()

	self._rooms = {}
	self._spawns = {}
	self._doors = {}
	self._entities = {}
	self._fgtiles = {}
	self._bgtiles = {}
	self._xtiles, self._ytiles = 0, 0

	for i,v in ipairs(data.layers) do
		if v.name == "FG" then
			self._xtiles = v.width
			self._ytiles = v.height
			self._fgtiles = v.data
		elseif v.name == "BG" then
			self._bgtiles = v.data
		elseif v.name == "OBJ" then
			for j, o in ipairs(v.objects) do
				if o.type == "room" then
					local r = Room(o.x/TILEW, o.y/TILEW, o.width/TILEW, o.height/TILEW, o.name)
					table.insert(self._rooms, r)

				elseif o.type == "door" then
					local d = {x = o.x/TILEW+1, y = o.y/TILEW+2, id = o.name}
					table.insert(self._doors, d)

				elseif o.type == "spawn" then
					local s = {x = o.x/TILEW, y = o.y/TILEW, id = o.name}
					table.insert(self._spawns, o)

				elseif o.type == "slime" then
					print("slime", o.x, o.y)
					table.insert(self._entities, o)
				end
			end
		end
	end

	-- Build doors
	for i, door in ipairs(self._doors) do
		for j, room in ipairs(self._rooms) do
			if door.y >= room.y and door.y < room.y+room.h then
				if door.x == room.x then
					door.right = room.id
				elseif door.x == room.x+room.w then	
					door.left = room.id
				end
			end
		end
	end

	-- Build rooms
	for i,v in ipairs(self._rooms) do
		-- Setup tiles
		for iy=v.y, v.y+v.h-1 do
			for ix=v.x, v.x+v.w-1 do
				local fg, bg = self:getTile(ix, iy)
				table.insert(v.fgtiles, fg)
				table.insert(v.bgtiles, bg)
			end
		end
		-- Find doors
		for j, w in ipairs(self._doors) do
			if w.left == v.id or w.right == v.id then
				local d = { x = (w.x-v.x)*TILEW, y = (w.y-v.y)*TILEW, left = w.left, right = w.right, id = w.id }
				table.insert(v.doors, d)
			end
		end
	end
end

function WorldData:getRooms()
	return self._rooms
end

function WorldData:getSpawns()
	return self._spawns
end

function WorldData:getTile(x, y)
	return self._fgtiles[x + y*self._xtiles + 1], 
	       self._bgtiles[x + y*self._xtiles + 1]
end

function WorldData:getRoom(id)
	for i,v in ipairs(self._rooms) do
		if v.id == id then
			return v
		end
	end
end

return WorldData
