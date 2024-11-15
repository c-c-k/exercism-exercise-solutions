return function(search_limit)
  -- NOTE: These two variables should properly be inside the coroutine
  --  as that would then remove the wrapper function scope,
  --  however as the composites table needs to be returned for the
  --  ./sieve-clock.lua comparison script they were moved outside of
  --  the coroutine.
  local composites = {}
  local max_factor = math.floor(search_limit ^ 0.5)

  return coroutine.create(function()
    for candidate = 2, max_factor do
      if not composites[candidate] then
        coroutine.yield(candidate)
        for composite = candidate ^ 2, search_limit, candidate do
          composites[composite] = true
        end
      end
    end
    for candidate = max_factor + 1, search_limit do
      if not composites[candidate] then coroutine.yield(candidate) end
    end
  end),
    composites
end
