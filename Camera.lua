local Camera = class("Camera")

Camera.static.zoom = 1
Camera.static.x = 0
Camera.static.y = 0

function Camera.static:setPosition(x, y)
	Camera.static.x = x
	Camera.static.y = y
end

return Camera
