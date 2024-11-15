-- NOTE: This version is slightly optimized to
--  skip testing multiples of 2 as prime candidates

return function(search_limit)
  local composites = {}
  local max_factor = math.floor(search_limit ^ 0.5)

  return coroutine.create(function()
    if search_limit >= 2 then coroutine.yield(2) end

    for candidate = 3, max_factor, 2 do
      if not composites[candidate] then
        coroutine.yield(candidate)
        for composite = candidate ^ 2, search_limit, candidate do
          composites[composite] = true
        end
      end
    end

    for candidate = max_factor + (max_factor % 2 == 0 and 1 or 2), search_limit, 2 do
      if not composites[candidate] then coroutine.yield(candidate) end
    end
  end),
    composites
end
