local SEARCH_LIMIT = 1000005
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
  assert(n > 0, "input number to n'th prime must be positive")
  if not primes then sieve_of_eratosthenes() end
  return primes[n]
end
