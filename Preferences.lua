require("Tserial")

local Preferences = class("Preferences")

Preferences.static.data = {}
Preferences.static.path = "preferences"

function Preferences.static:load()
	if love.filesystem.exists(self.path) == false then return end

	local strdata = love.filesystem.read(self.path)
	local data = Tserial.unpack(strdata)
	for i,v in pairs(data) do
		self.data[i] = v
	end
end

function Preferences.static:save()
	local strdata = Tserial.pack(self.data)
	love.filesystem.write(self.path, strdata)
end

function Preferences.static:set(key, value)
	self.data[key] = value
	self:save()
end

function Preferences.static:get(key, default)
	local val = self.data[key]
	if val ~= nil then
		return val
	else
		return default
	end
end

return Preferences
