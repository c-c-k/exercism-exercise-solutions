return function(amount, values)
  local results = {}
  local inverse = {}
  local sorted = {}

  for index, value in ipairs(values) do
    inverse[value] = index
    sorted[index] = value
  end

  table.sort(sorted, function(a, b) return a > b end)

  for _, value in ipairs(sorted) do
    results[inverse[value]] = math.floor(amount / value)
    amount = amount % value
  end

  return amount == 0 and results or nil
end
