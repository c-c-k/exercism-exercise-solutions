local color_codes_map = {
  black = 0,
  brown = 1,
  red = 2,
  orange = 3,
  yellow = 4,
  green = 5,
  blue = 6,
  violet = 7,
  grey = 8,
  white = 9,
}
local unit_prefixes = { [3] = 'kilo', [6] = 'mega', [9] = 'giga' }

return {
  decode = function(c1, c2, c3)
    local value = (color_codes_map[c1] * 10 + color_codes_map[c2])
      * 10 ^ color_codes_map[c3]

    local unit = 'ohms'
    for i = 9, 3, -3 do
      local magnitude = 10 ^ i
      if value > magnitude then
        value = value / magnitude
        unit = unit_prefixes[i] .. unit
        break
      end
    end

    return value, unit
  end,
}
