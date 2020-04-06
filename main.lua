push = require 'push'

-- Globals
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH, WINDOW_HEIGHT = WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 248
SCORE_FONT = 32

BALL_SIZE = 4
BALL_SPEED = 120
PADDLE_SPEED = 300
PADDLE_WIDTH = 6
PADDLE_HEIGHT = 40

-- Initial configuration
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())
  
  -- UI
  love.window.setTitle('Pong')
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

  -- Ball
  ballX = (VIRTUAL_WIDTH / 2) - (BALL_SIZE / 2)
  ballY = (VIRTUAL_HEIGHT / 2) - (BALL_SIZE / 2)
  ballDX = math.random(2) == 1 and BALL_SPEED or -BALL_SPEED
  ballDY = math.random(-50, 50) * 1.5

  gameState = 'start'
end

-- Movement
function love.update(dt)
  -- Player1
  if love.keyboard.isDown('w') then
    player1Y = math.max(0, player1Y + -(PADDLE_SPEED * dt))
  elseif love.keyboard.isDown('s') then
    player1Y = math.min(VIRTUAL_HEIGHT - PADDLE_HEIGHT, player1Y + (PADDLE_SPEED * dt))
  end
  
  -- Player2
  if love.keyboard.isDown('up') then
    player2Y = math.max(0, player2Y + -(PADDLE_SPEED * dt))
  elseif love.keyboard.isDown('down') then
    player2Y = math.min(VIRTUAL_HEIGHT - PADDLE_HEIGHT, player2Y + (PADDLE_SPEED * dt))
  end

  -- Ball
  if gameState == 'play' then
    ballX = ballX + ballDX * dt
    ballY = ballY + ballDY * dt
  end
end

-- Control state of the game
function love.keypressed(key)
  print(key)
  
  if (key == 'escape') then
    love.event.quit()
  end

  if (key == 'return') then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'

      -- reset ball
      ballX = (VIRTUAL_WIDTH / 2) - (BALL_SIZE / 2)
      ballY = (VIRTUAL_HEIGHT / 2) - (BALL_SIZE / 2)
      ballDX = math.random(2) == 1 and 100 or -100
      ballDY = math.random(-50, 50) * 1.5
    end
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

-- Render
function love.draw()
  push:apply('start')
  
  love.graphics.clear(0, 0, 0, 1)

  -- UI
  love.graphics.setFont(font)
  love.graphics.printf('Pong!', 0, 16, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(fontScore)
  love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - SCORE_FONT / 2 - SCORE_FONT, 36)
  love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + SCORE_FONT, 36)

  -- Players
  love.graphics.rectangle('fill', player1X, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
  love.graphics.rectangle('fill', player2X, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)
  
  -- Ball
  love.graphics.rectangle('fill', ballX, ballY, BALL_SIZE, BALL_SIZE)

  push:apply('end')
end