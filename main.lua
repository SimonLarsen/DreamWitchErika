require("mymath")
class = require("middleclass.middleclass")
gamestate = require("hump.gamestate")
Resources = require("Resources")
Camera = require("Camera")
Input = require("Input")

WIDTH = 320
HEIGHT = 180
SCALE = 3
TILEW = 20

function love.load()
	love.window.setMode(WIDTH*SCALE, HEIGHT*SCALE)
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setBackgroundColor(168, 216, 239)

	gamestate.registerEvents()
	gamestate.switch(require("GameScene")())

	Camera.static.zoom = SCALE
end

function love.update(dt)

end

function love.draw()
	Input.static:update()
	love.graphics.push()

	love.graphics.scale(Camera.static.zoom)
	love.graphics.translate(-Camera.static.x+WIDTH/2, -Camera.static.y+HEIGHT/2)
end

function love.gui()
	love.graphics.pop()

	love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
end

function love.keypressed(k)
	Input.static:keypressed(k)
end

function love.keyreleased(k)
	Input.static:keyreleased(k)
end

function love.run()
    if love.math then
        love.math.setRandomSeed(os.time())
    end

    if love.event then
        love.event.pump()
    end

    if love.load then love.load(arg) end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

        if love.window and love.graphics and love.window.isCreated() then
            love.graphics.clear()
            love.graphics.origin()
            if love.draw then love.draw() end
			if love.gui then love.gui() end
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end
