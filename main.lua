push = require 'push'

-- Configuration
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 248
 
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  font = love.graphics.newFont('res/font.ttf', 8)
  love.graphics.setFont(font)
  love.window.setTitle('Pong')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true,
    pixelperfect = true
  })
end

function love.keypressed(key)
  if (key == 'escape') then
    print(key)
    love.event.quit()
  end
end

function love.draw()
  push:apply('start')

  love.graphics.printf('Hello Pong!', 0, (VIRTUAL_HEIGHT / 2 - 6), VIRTUAL_WIDTH, 'center')

  push:apply('end')
end