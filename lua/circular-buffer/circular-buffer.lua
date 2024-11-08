local function _circular_increment(current, size)
  -- NOTE: The logic here assumes `current` is an index for an array starting at 1 and ending at `size`, hence the rollover point is when `current == size` and not when `current + 1 == size`.
  return current % size + 1
end

local CircularBuffer = {}

CircularBuffer.__index = CircularBuffer

function CircularBuffer:new(size)
  local _buffer = setmetatable({ size = size, first = 1, next = 1 }, self)

  return _buffer
end

function CircularBuffer:_is_empty() return self[self.first] == nil end

function CircularBuffer:_is_full()
  return not self:_is_empty() and self.next == self.first
end

function CircularBuffer:write(value)
  if self:_is_full() then error("buffer is full", 2) end

  return self:forceWrite(value)
end

function CircularBuffer:forceWrite(value)
  if value == nil then return end

  if self:_is_full() then
    self.first = _circular_increment(self.first, self.size)
  end

  self[self.next] = value
  self.next = _circular_increment(self.next, self.size)
end

function CircularBuffer:read()
  if self:_is_empty() then error("buffer is empty", 2) end

  local value = self[self.first]
  self[self.first] = nil
  self.first = _circular_increment(self.first, self.size)

  return value
end

function CircularBuffer:clear()
  for i = 1, self.size do
    self[i] = nil
  end

  self.first = 1
  self.next = 1
end

return CircularBuffer
