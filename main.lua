push = require 'push'

-- Globals
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 248
SCORE_FONT = 32

PADDLE_SPEED = 300
PADDLE_WIDTH = 6
PADDLE_HEIGHT = 40

-- Initial configuration
function love.load()
  love.window.setTitle('Pong')

  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  font = love.graphics.newFont('res/font.ttf', 8)
  fontScore = love.graphics.newFont('res/font.ttf', SCORE_FONT)
  

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true,
    pixelperfect = true
  })
  push:setBorderColor{51, 51, 51}

  -- Players
  player1Score = 0
  player2Score = 0
  player1X = 16
  player2X = VIRTUAL_WIDTH - (player1X + PADDLE_WIDTH)
  player1Y = 36
  player2Y = VIRTUAL_HEIGHT - (PADDLE_HEIGHT + player1Y)
end

function love.update(dt)
  -- Player1 movement
  if love.keyboard.isDown('w') then
    player1Y = player1Y + -(PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
    player1Y = player1Y + (PADDLE_SPEED * dt)
  end
  
  -- Player2 movement
  if love.keyboard.isDown('up') then
    player2Y = player2Y + -(PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('down') then
    player2Y = player2Y + (PADDLE_SPEED * dt)
  end
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
  
  love.graphics.clear(0, 0, 0, 1)

  -- UI
  love.graphics.setFont(font)
  love.graphics.printf('Pong!', 0, 16, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(fontScore)
  love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - SCORE_FONT / 2 - SCORE_FONT, 36)
  love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + SCORE_FONT, 36)

  -- Render Players
  love.graphics.rectangle('fill', player1X, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
  love.graphics.rectangle('fill', player2X, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)
  
  -- Render Ball
  ballSize = 4
  love.graphics.rectangle('fill', (VIRTUAL_WIDTH / 2) - (ballSize / 2), (VIRTUAL_HEIGHT / 2) - (ballSize / 2), ballSize, ballSize)

  push:apply('end')
end