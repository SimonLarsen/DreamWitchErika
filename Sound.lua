local Sound = {}

local music

function Sound.play(name)
	love.audio.play(Resources.static:getSound(name .. ".wav"))
end

function Sound.music(name)
	if music ~= nil then
		music:stop()
	end
	music = love.audio.newSource("data/music/" .. name .. ".ogg")
	music:setVolume(0.5)
	music:setLooping(true)
	love.audio.play(music)
end

return Sound
