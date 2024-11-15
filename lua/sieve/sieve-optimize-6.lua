-- NOTE: This version is slightly optimized to
--  skip testing multiples of 2 and 3 as prime candidates

return function(search_limit)
  local composites = {}
  local max_factor = math.floor(search_limit ^ 0.5)

  return coroutine.create(function()
    if search_limit >= 2 then coroutine.yield(2) end
    if search_limit >= 3 then coroutine.yield(3) end

    local skip_4 = false
    local candidate = 5

    while candidate <= max_factor do
      if not composites[candidate] then
        coroutine.yield(candidate)
        for composite = candidate ^ 2, search_limit, candidate do
          composites[composite] = true
        end
      end

      candidate = candidate + (skip_4 and 4 or 2)
      skip_4 = not skip_4
    end

    while candidate <= search_limit do
      if not composites[candidate] then coroutine.yield(candidate) end

      candidate = candidate + (skip_4 and 4 or 2)
      skip_4 = not skip_4
    end
  end),
    composites
end
