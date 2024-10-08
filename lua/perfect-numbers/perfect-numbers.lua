local function aliquot_sum(n)
  if n == 1 then return 0 end

  local divisor = 2
  local quotient, fraction = math.modf(n / divisor)
  local sum = 1

  while divisor < quotient do
    if fraction == 0 then sum = sum + divisor + quotient end
    divisor = divisor + 1
    quotient, fraction = math.modf(n / divisor)
  end
  if fraction == 0 and divisor == quotient then sum = sum + divisor end

  return sum
end

local function classify(n)
  local sum = aliquot_sum(n)
  return sum == n and "perfect" or (sum > n and "abundant" or "deficient")
end

return { aliquot_sum = aliquot_sum, classify = classify }
