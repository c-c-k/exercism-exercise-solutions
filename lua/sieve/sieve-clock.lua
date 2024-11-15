-- NOTE: Comparison of the different implementations
-- Results:
-- ./sieve-optimize-6.lua  (10^1): clock: 0.000018 s, cache: 0
-- ./sieve-optimize-2.lua  (10^1): clock: 0.000015 s, cache: 1
-- ./sieve.lua             (10^1): clock: 0.000021 s, cache: 5
-- ./sieve-modulo.lua      (10^1): clock: 0.000013 s, cache: 4
-- ./sieve-optimize-6.lua  (10^3): clock: 0.000104 s, cache: 453
-- ./sieve-optimize-2.lua  (10^3): clock: 0.000091 s, cache: 640
-- ./sieve.lua             (10^3): clock: 0.000107 s, cache: 831
-- ./sieve-modulo.lua      (10^3): clock: 0.000991 s, cache: 168
-- ./sieve-optimize-6.lua  (10^5): clock: 0.012821 s, cache: 67745
-- ./sieve-optimize-2.lua  (10^5): clock: 0.011433 s, cache: 79415
-- ./sieve.lua             (10^5): clock: 0.011814 s, cache: 90407
-- ./sieve-modulo.lua      (10^5): clock: 2.551520 s, cache: 9592

local REPEATS = 10
local implementations = {
  "./sieve-optimize-6.lua",
  "./sieve-optimize-2.lua",
  "./sieve.lua",
  "./sieve-modulo.lua",
}
for exponent = 1, 5, 2 do
  for _, implementation in ipairs(implementations) do
    local test = dofile(implementation)
    local sum = 0
    local cache

    for _ = 1, REPEATS do
      local t0 = os.clock()
      local co
      co, cache = test(10 ^ exponent)
      while true do
        local _, prime = coroutine.resume(co)
        if prime == nil then break end
      end
      sum = sum + os.clock() - t0
    end

    local cache_size = 0
    for _, _ in pairs(cache) do
      cache_size = cache_size + 1
    end

    print(
      ("%-23s (10^%i): clock: %f s, cache: %i"):format(
        implementation,
        exponent,
        sum / REPEATS,
        cache_size
      )
    )
  end
end
