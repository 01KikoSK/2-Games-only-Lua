-- Initialize the game
local width, height = 10, 20
local grid = {}
for y = 1, height do
  grid[y] = {}
  for x = 1, width do
    grid[y][x] = 0
  end
end

local tetrominoes = {
  { -- I-Shape
    {x = 0, y = 0},
    {x = 1, y = 0},
    {x = 2, y = 0},
    {x = 3, y = 0}
  },
  { -- J-Shape
    {x = 0, y = 0},
    {x = 0, y = 1},
    {x = 1, y = 1},
    {x = 2, y = 1}
  },
  { -- L-Shape
    {x = 2, y = 0},
    {x = 2, y = 1},
    {x = 1, y = 1},
    {x = 0, y = 1}
  },
  { -- O-Shape
    {x = 0, y = 0},
    {x = 1, y = 0},
    {x = 0, y = 1},
    {x = 1, y = 1}
  },
  { -- S-Shape
    {x = 1, y = 0},
    {x = 2, y = 0},
    {x = 0, y = 1},
    {x = 1, y = 1}
  },
  { -- T-Shape
    {x = 1, y = 0},
    {x = 0, y = 1},
    {x = 1, y = 1},
    {x = 2, y = 1}
  },
  { -- Z-Shape
    {x = 0, y = 0},
    {x = 1, y = 0},
    {x = 1, y = 1},
    {x = 2, y = 1}
  }
}

local currentTetromino = tetrominoes[math.random(#tetrominoes)]
local currentX, currentY = 5, 1

-- Function to draw the game board
local function drawBoard()
  for y = 1, height do
    for x = 1, width do
      if grid[y][x] == 1 then
        io.write("#") -- Block
      else
        io.write(" ") -- Empty space
      end
    end
    io.write("\n")
  end
end

-- Function to check if a tetromino can be placed at a given position
local function canPlace(tetromino, x, y)
  for _, block in ipairs(tetromino) do
    local bx, by = x + block.x, y + block.y
    if bx < 1 or bx > width or by < 1 or by > height then
      return false
    end
    if grid[by][bx] == 1 then
      return false
    end
  end
  return true
end

-- Function to place a tetromino at a given position
local function placeTetromino(tetromino, x, y)
  for _, block in ipairs(tetromino) do
    local bx, by = x + block.x, y + block.y
    grid[by][bx] = 1
  end
end

-- Function to check for a complete line
local function checkLine()
  for y = 1, height do
    local complete = true
    for x = 1, width do
      if grid[y][x] == 0 then
        complete = false
        break
      end
    end
    if complete then
      -- Remove the complete line
      for x = 1, width do
        grid[y][x] = 0
      end
      -- Shift all lines above down
      for y2 = y, 2, -1 do
        for x = 1, width do
          grid[y2][x] = grid[y2 - 1][x]
        end
      end
    end
  end
end

-- Main game loop
while true do
  -- Draw the game board
  drawBoard()
  
  -- Get user input
  io.write("Enter direction (A/D): ")
  local input = io.read()
  if input == "a" then
    -- Move left
    if canPlace(currentTetromino, currentX