local function round(num, precision)
  local rounded = math.floor(num * 10 ^ (precision + 1)) + 5
  rounded = math.floor(rounded / 10)
  return rounded / 10 ^ precision
end

local _EARTH_YEAR_SECONDS = 31557600
local _PLANET_YEARS_RATIOS = {
  earth = 1,
  mercury = 0.2408467,
  venus = 0.61519726,
  mars = 1.8808158,
  jupiter = 11.862615,
  saturn = 29.447498,
  uranus = 84.016846,
  neptune = 164.79132,
}

local SpaceAge = {}

function SpaceAge:new(seconds)
  local age = {
    seconds = seconds,
  }

  for planet, ratio in pairs(_PLANET_YEARS_RATIOS) do
    local _age = round((seconds / _EARTH_YEAR_SECONDS / ratio), 2)
    age['on_' .. planet] = function()
      return _age
    end
  end

  return age
end

return SpaceAge
