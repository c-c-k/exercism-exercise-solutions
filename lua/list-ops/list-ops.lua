local function reduce(xs, acc, f)
  for _, value in ipairs(xs) do
    acc = f(value, acc)
  end
  return acc
end

local function map(xs, f)
  local result = {}
  for _, value in ipairs(xs) do
    result[#result + 1] = f(value)
  end
  return result
end

local function filter(xs, pred)
  local result = {}
  for _, value in ipairs(xs) do
    if pred(value) then result[#result + 1] = value end
  end
  return result
end

return { map = map, reduce = reduce, filter = filter }
