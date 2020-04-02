push = require 'push'

-- Configuration
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 248
 
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  font = love.graphics.newFont('res/font.ttf', 16)
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

function drawLine ()
  rx, ry = love.math.random( 0, love.graphics.getWidth() ), love.math.random( 0, love.graphics.getHeight() )
  love.graphics.setColor( love.math.random( ), love.math.random( ), love.math.random( ) )
  love.graphics.line( 0, 0, rx, ry )
end

function drawRectangle ()
  rx, ry = love.math.random( 0, love.graphics.getWidth() ), love.math.random( 0, love.graphics.getHeight() )
  love.graphics.setColor( love.math.random( ), love.math.random( ), love.math.random( ) )
  love.graphics.rectangle('line',love.math.random( 0, love.graphics.getWidth() ), love.math.random( 0, love.graphics.getHeight() ), love.math.random( 0, love.graphics.getWidth() ), love.math.random( 0, love.graphics.getHeight() ))
end

function love.draw()
  push:apply('start')

  love.graphics.clear(255, 0, 255)
  love.graphics.printf('Pong!', 0, 16, VIRTUAL_WIDTH, 'center')

  -- Render: Player
  paddleInitialX = 16
  paddleInitialY = 36
  paddleSize = 40
  love.graphics.rectangle('fill', paddleInitialX, paddleInitialY, 5, paddleSize)
  -- Render: Enemy
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - paddleInitialX, VIRTUAL_HEIGHT - (paddleSize + paddleInitialY), 5, paddleSize)
  
  -- Render: Ball
  ballSize = 4
  love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - (ballSize * 2), VIRTUAL_HEIGHT / 2 - (ballSize * 2), ballSize, ballSize)

  push:apply('end')
end