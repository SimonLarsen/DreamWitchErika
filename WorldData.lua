local Room = require("Room")
local Entity = require("Entity")

local WorldData = class("WorldData")

function WorldData:initialize()
	local chunk = love.filesystem.load("data/maps/map.lua")
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
					local r = Room(o.x, o.y, o.width, o.height, Entity.static:getId())
					table.insert(self._rooms, r)

				elseif o.type == "door" then
					local d = {x = o.x+o.width/2, y = o.y+o.height/2, id = Entity.static:getId(), black=false}
					table.insert(self._doors, d)

				elseif o.type == "blackdoor" then
					local d = {x = o.x+o.width/2, y = o.y+o.height/2, id = Entity.static:getId(), black=true}
					table.insert(self._doors, d)

				elseif o.type == "spawn" then
					local s = {x = o.x+o.width/2, y = o.y+o.height/2, id = o.name}
					table.insert(self._spawns, s)

				else
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
	for i, room in ipairs(self._rooms) do
		-- Setup tiles
		local cx, cy = room.x/TILEW, room.y/TILEW
		local cw, ch = room.w/TILEW, room.h/TILEW
		for iy=cy, cy+ch-1 do
			for ix=cx, cx+cw-1 do
				local fg, bg = self:getTile(ix, iy)
				table.insert(room.fgtiles, fg)
				table.insert(room.bgtiles, bg)
			end
		end
		-- Find doors and entities in room
		for j, door in ipairs(self._doors) do
			if door.left == room.id or door.right == room.id then
				local d = { x = door.x-room.x, y = door.y-room.y, left = door.left, right = door.right, id = door.id, black = door.black }
				table.insert(room.doors, d)
			end
		end

		for j, e in ipairs(self._entities) do
			if e.x >= room.x and e.x <= room.x+room.w
			and e.y >= room.y and e.y <= room.y+room.h then
				local newe = { x = e.x-room.x, y = e.y-room.y, type = e.type, id = e.id }
				table.insert(room.entities, newe)
			end
		end

		for j, spawn in ipairs(self._spawns) do
			if spawn.room == nil 
			and spawn.x >= room.x and spawn.x <= room.x+room.w
			and spawn.y >= room.y and spawn.y <= room.y+room.h then
				spawn.x = spawn.x - room.x
				spawn.y = spawn.y - room.y
				spawn.room = room.id
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
