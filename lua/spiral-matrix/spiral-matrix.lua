local RIGHT = 0
local DOWN = 1
local LEFT = 2
local UP = 3

return function(size)
  local rows = {}
  for row = 1, size do
    rows[row] = {}
  end

  local row = 1
  local column = 0
  local value = 0
  local final_value = size ^ 2
  local depth = 0
  local direction = RIGHT

  while value < final_value do
    local advance = size - depth
    for _ = 1, advance do
      if direction == RIGHT then
        column = column + 1
      elseif direction == DOWN then
        row = row + 1
      elseif direction == LEFT then
        column = column - 1
      else
        row = row - 1
      end
      value = value + 1
      rows[row][column] = value
    end

    direction = (direction + 1) % 4
    if direction == DOWN or direction == UP then depth = depth + 1 end
  end

  return rows
end
