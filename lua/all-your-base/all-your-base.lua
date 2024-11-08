local function validate_from(from_digits, from_base)
  if from_base <= 1 then return error("invalid input base", 3) end
  for _, digit in ipairs(from_digits) do
    if digit >= from_base then return error("digit out of range", 3) end
    if digit < 0 then return error("negative digits are not allowed", 3) end
  end
end

local function validate_to(to_base)
  if to_base <= 1 then return error("invalid output base", 3) end
end

local function reverse_in_place(table)
  local len = #table

  for i = 1, math.floor(len / 2) do
    local temp = table[i]
    table[i] = table[len - i + 1]
    table[len - i + 1] = temp
  end

  return table
end

local function convert_to_decimal_num(from_digits, from_base)
  local decimal_num = 0

  for _, digit in ipairs(from_digits) do
    decimal_num = decimal_num * from_base + digit
  end

  return decimal_num
end

local function convert_to_base(decimal_num, base)
  local result = {}

  repeat
    table.insert(result, decimal_num % base)
    decimal_num = math.floor(decimal_num / base)
  until decimal_num <= 0

  return reverse_in_place(result)
end

local all_your_base = {}

all_your_base.convert = function(from_digits, from_base)
  validate_from(from_digits, from_base)

  local decimal_num = convert_to_decimal_num(from_digits, from_base)

  return {
    to = function(to_base)
      validate_to(to_base)

      return convert_to_base(decimal_num, to_base)
    end,
  }
end

return all_your_base
