-- NOTE: This is a solution optimized for multiple queries while also being able to handle queries for big numbers and big primes, adjusted from:
-- 1. <https://www.geeksforgeeks.org/prime-factorization-using-sieve-olog-n-multiple-queries/>
-- 2. <https://www.geeksforgeeks.org/least-prime-factor-of-numbers-till-n/>
-- 3. ./prime-factors-ver2.lua and ./prime-factors-ver3.lua

local SEARCH_LIMIT = 10 ^ 7
local lpf_cache, primes_cache

local function generate_least_prime_factors_cache()
  lpf_cache = {}
  primes_cache = {}
  for num = 2, SEARCH_LIMIT do
    if not lpf_cache[num] then
      primes_cache[#primes_cache + 1] = num
      for multiple = num, SEARCH_LIMIT, num do
        if not lpf_cache[multiple] then lpf_cache[multiple] = num end
      end
    end
  end
end

local function extract_pf_from_big_numbers(n, prime_factors)
  for _, prime in ipairs(primes_cache) do
    if n < SEARCH_LIMIT then break end

    while n % prime == 0 do
      prime_factors[#prime_factors + 1] = prime
      n = n / prime
    end
  end

  return n
end

local function extract_factor(factor, n, factors)
  while n % factor == 0 do
    factors[#factors + 1] = factor
    n = n / factor
  end

  return n
end

local function extract_big_prime_factors(n, prime_factors)
  local max_seed = math.floor((n ^ 0.5) / 6) + 1
  local min_seed = math.floor(SEARCH_LIMIT / 6)

  for seed = min_seed, max_seed do
    if n == 1 then break end

    n = extract_factor((seed * 6) - 1, n, prime_factors)
    n = extract_factor((seed * 6) + 1, n, prime_factors)
  end

  if n ~= 1 then prime_factors[#prime_factors + 1] = n end

  return n
end

local function extract_normal_prime_factors(n, prime_factors)
  while n > 1 do
    local prime_factor = lpf_cache[n]
    while n % prime_factor == 0 do
      prime_factors[#prime_factors + 1] = prime_factor
      n = n / prime_factor
    end
  end
end

return function(n)
  if not lpf_cache then generate_least_prime_factors_cache() end
  local prime_factors = {}

  if n > SEARCH_LIMIT then n = extract_pf_from_big_numbers(n, prime_factors) end
  if n > SEARCH_LIMIT then
    n = extract_big_prime_factors(n, prime_factors)
  else
    extract_normal_prime_factors(n, prime_factors)
  end

  return prime_factors
end
