return {
  valid = function(s)
    if s == "0" then return false end

    s = tonumber(s:gsub(" ", ""), 10)
    if not s then return false end

    local sum = 0
    local odd = true

    while s > 0 do
      local num = s % 10
      s = math.floor(s / 10)

      num = odd and num or (num == 9 and 9 or (num * 2) % 9)
      odd = not odd
      sum = sum + num
    end
    return sum % 10 == 0
  end,
}
