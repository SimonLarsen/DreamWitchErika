local Sound = {}

function Sound.play(name)
	love.audio.play(Resources.static:getSound(name .. ".wav"))
end

return Sound
