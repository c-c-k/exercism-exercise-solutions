-- NOTE: This solution does not qualify according to
--  the requirement to use the Sieve of Eratosthenes
--  but is here to compare performance with the one that does.

return function(search_limit)
  local primes = {}

  return coroutine.create(function()
    for num = 2, search_limit do
      local is_prime = true

      for _, prime in ipairs(primes) do
        if num % prime == 0 then
          is_prime = false
          break
        end
      end

      if is_prime then
        primes[#primes + 1] = num
        coroutine.yield(num)
      end
    end
  end),
    primes
end
