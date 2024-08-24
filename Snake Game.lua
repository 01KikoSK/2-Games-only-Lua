-- Initialize the game
local width, height = 20, 20
local snake = {{x = 1, y = 1}}
local direction = "right"
local food = {x = math.random(1, width), y = math.random(1, height)}
local score = 0

-- Function to draw the game board
local function drawBoard()
  for y = 1, height do
    for x = 1, width do
      if x == food.x and y == food.y then
        io.write("F") -- Food
      elseif x == snake[1].x and y == snake[1].y then
        io.write("S") -- Snake head
      elseif contains(snake, {x = x, y = y}) then
        io.write("s") -- Snake body
      else
        io.write(".") -- Empty space
      end
    end
    io.write("\n")
  end
end

-- Function to check if a point is in the snake's body
local function contains(t, point)
  for i, v in ipairs(t) do
    if v.x == point.x and v.y == point.y then
      return true
    end
  end
  return false
end

-- Function to move the snake
local function moveSnake()
  local head = snake[1]
  local newHead = {x = head.x, y = head.y}
  if direction == "right" then
    newHead.x = newHead.x + 1
  elseif direction == "left" then
    newHead.x = newHead.x - 1
  elseif direction == "up" then
    newHead.y = newHead.y - 1
  elseif direction == "down" then
    newHead.y = newHead.y + 1
  end
  
  -- Check for collision with food
  if newHead.x == food.x and newHead.y == food.y then
    score = score + 1
    food = {x = math.random(1, width), y = math.random(1, height)}
  else
    -- Remove the last segment of the snake
    table.remove(snake, #snake)
  end
  
  -- Add the new head to the snake
  table.insert(snake, 1, newHead)
end

-- Main game loop
while true do
  -- Draw the game board
  drawBoard()
  
  -- Get user input
  io.write("Enter direction (W/A/S/D): ")
  local input = io.read()
  if input == "w" then
    direction = "up"
  elseif input == "a" then
    direction = "left"
  elseif input == "s" then
    direction = "down"
  elseif input == "d" then
    direction = "right"
  end
  
  -- Move the snake
  moveSnake()
  
  -- Check for collision with the wall or itself
  if snake[1].x < 1 or snake[1].x > width or snake[1].y < 1 or snake[1].y > height or contains(snake, snake[1], 2) then
    print("Game over! Final score: " .. score)
    break
  end
end