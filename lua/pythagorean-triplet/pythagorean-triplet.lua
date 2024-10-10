--- Adjusted from <https://www.geeksforgeeks.org/pythagorean-triplet-with-given-sum-using-single-loop>
return function(n)
  local triplets = {}
  local a, b, c = 1, nil, nil

  repeat
    b = n * (n - 2 * a) / (2 * (n - a))
    c = n - a - b
    if b % 1 == 0 then triplets[#triplets + 1] = { a, b, c } end

    a = a + 1
  until a >= b

  return triplets
end
