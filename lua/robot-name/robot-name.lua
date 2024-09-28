local Robot = {}

function Robot.new(self, o)
  local robot = o or {}
  setmetatable(robot, self)
  self.__index = self
  if not self._names then self._names = {} end
  robot:reset()
  return robot
end

function Robot.reset(self)
  local name = self.name
  local prev_name = name
  local names = self._names

  repeat
    name = ''
    for _ = 1, 2 do
      name = name .. string.char(math.random(65, 90))
    end
    name = name .. string.format('%03u', math.random(0, 999))
  until not names[name] and name ~= prev_name

  names[name] = true
  self.name = name
end

return Robot
