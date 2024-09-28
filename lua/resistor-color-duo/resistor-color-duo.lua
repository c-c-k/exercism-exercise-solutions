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

return {
  value = function(color)
    return color_codes_map[color[1]] * 10 + color_codes_map[color[2]]
  end,
}
