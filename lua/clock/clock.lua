---@class Clock
---@field protected _hours integer
---@field protected _minutes integer
local Clock = {}

Clock.__index = Clock

--- Represents the Clock object as a string in the format "%H:%M"
---@return string
function Clock:__tostring()
  return ('%02i:%02i'):format(self._hours, self._minutes)
end

---@param hours integer
---@param minutes integer
function Clock:_apply_offset(hours, minutes)
  minutes = self._minutes + minutes
  hours = self._hours + hours
  self._hours = (hours + math.floor(minutes / 60)) % 24
  self._minutes = minutes % 60
end

--- Creates a new Clock object representing the given time.
---
--- The time is taken as an offset from "00:00".
--- Negative and overflowing values are rolled over (0<=hours<24, 0<=minutes<60).
--- Default values are "00".
---@param hours integer?
---@param minutes integer?
---@return Clock
function Clock.at(hours, minutes)
  local o = setmetatable({}, Clock)
  o._hours = 0
  o._minutes = 0
  o:_apply_offset(hours or 0, minutes or 0)
  return o
end

--- Increments the Clock object's time by a given number of minutes.
---@param minutes integer
---@return Clock
function Clock:plus(minutes)
  self:_apply_offset(0, minutes)
  return self
end

--- Decrements the Clock object's time by a given number of minutes.
---@param minutes integer
---@return Clock
function Clock:minus(minutes)
  self:_apply_offset(0, -1 * minutes)
  return self
end

--- Determines if the current Clock object is equal to another Clock object.
---@param other Clock
---@return boolean
function Clock:equals(other)
  return self._minutes == other._minutes and self._hours == other._hours
end

return Clock
