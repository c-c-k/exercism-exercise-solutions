-- NOTE: This is the common solution also optimized according to:
-- 1. <https://www.geeksforgeeks.org/prime-factor/>
-- 2. <https://exercism.org/tracks/lua/exercises/prime-factors/solutions/carlospavanetti>

local function extract_factor(factor, n, factors)
  while n % factor == 0 do
    factors[#factors + 1] = factor
    n = n / factor
  end

  return n
end

return function(n)
  local factors = {}
  local max_seed = math.floor((n ^ 0.5) / 6) + 1

  n = extract_factor(2, n, factors)
  n = extract_factor(3, n, factors)

  for seed = 1, max_seed do
    if n == 1 then break end

    n = extract_factor((seed * 6) - 1, n, factors)
    n = extract_factor((seed * 6) + 1, n, factors)
  end

  if n ~= 1 then factors[#factors + 1] = n end

  return factors
end
