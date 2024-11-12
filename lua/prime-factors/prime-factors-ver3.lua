-- NOTE: This is my original low efficiency sollution adjusted from ../nth-prime/nth-prime.lua

local SEARCH_LIMIT = 1000003
local primes

local function sieve_of_eratosthenes()
  primes = {}
  local non_primes = {}
  for num = 2, SEARCH_LIMIT do
    if not non_primes[num] then
      table.insert(primes, num)
      for non_prime = num ^ 2, SEARCH_LIMIT, num do
        non_primes[non_prime] = true
      end
    end
  end
end

return function(n)
  if not primes then sieve_of_eratosthenes() end
  local factors = {}

  for _, prime in ipairs(primes) do
    if n == 1 then break end

    while n % prime == 0 do
      factors[#factors + 1] = prime
      n = n / prime
    end
  end

  return factors
end
