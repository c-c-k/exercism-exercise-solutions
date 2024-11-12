local OCTAL_VALUES = {
  ["0"] = 0,
  ["1"] = 1,
  ["2"] = 2,
  ["3"] = 3,
  ["4"] = 4,
  ["5"] = 5,
  ["6"] = 6,
  ["7"] = 7,
}

local function to_decimal(s)
  local decimal = 0

  for digit in s:gmatch "." do
    decimal = decimal * 8
    digit = OCTAL_VALUES[digit]
    if digit then
      decimal = decimal + digit
    else
      decimal = 0
      break
    end
  end

  return decimal
end

return function(s)
  return {
    to_decimal = function() return to_decimal(s) end,
  }
end
