local HEADINGS = { [0] = "north", [1] = "east", [2] = "south", [3] = "west" }
local HEADINGS_DATA = {
  north = { id = 0, axis = "y", delta = 1 },
  east = { id = 1, axis = "x", delta = 1 },
  south = { id = 2, axis = "y", delta = -1 },
  west = { id = 3, axis = "x", delta = -1 },
}

local function move(robot, commands)
  for command in commands:gmatch "." do
    if command == "R" then
      robot.heading = HEADINGS[(HEADINGS_DATA[robot.heading].id + 1) % 4]
    elseif command == "L" then
      robot.heading = HEADINGS[(HEADINGS_DATA[robot.heading].id - 1) % 4]
    elseif command == "A" then
      local axis = HEADINGS_DATA[robot.heading].axis
      robot[axis] = robot[axis] + HEADINGS_DATA[robot.heading].delta
    else
      error(('Illegal command: "%s"'):format(command), 2)
    end
  end
end

return function(config)
  config.move = move
  return config
end
