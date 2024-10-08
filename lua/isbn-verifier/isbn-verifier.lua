return {
  valid = function(isbn)
    local isbn_sum = 0
    local iter = isbn:gmatch "[%dX]"
    local digit = iter()

    for i = 10, 2, -1 do
      if not digit or digit == "X" then return false end
      isbn_sum = isbn_sum + tonumber(digit) * i
      digit = iter()
    end

    if not digit then return false end
    if iter() then return false end
    digit = digit == "X" and 10 or tonumber(digit)

    return (isbn_sum + digit) % 11 == 0
  end,
}
