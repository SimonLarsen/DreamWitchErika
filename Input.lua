local Input = class("Input")

Input.static.down = {}
Input.static.pressed = {}

function Input.static:isDown(k)
	return Input.static.down[k] == true
end

function Input.static:wasPressed(k)
	return Input.static.pressed[k] == true
end

function Input.static:keypressed(k)
	Input.static.down[k] = true
	Input.static.pressed[k] = true
end

function Input.static:keyreleased(k)
	Input.static.down[k] = false
end

function Input.static:update(dt)
	for i,v in pairs(Input.static.pressed) do
		Input.static.pressed[i] = false
	end
end

return Input
