local function to_decimal(input)
  local decimal = 0

  for digit in input:gmatch '.' do
    decimal = decimal * 2
    if digit == '1' then
      decimal = decimal + 1
    elseif digit ~= '0' then
      decimal = 0
      break
    end
  end

  return decimal
end

return { to_decimal = to_decimal }
