return {
  valid = function(s)
    local len = #s
    if len == 1 then return false end

    local sum = 0
    local double = len % 2 == 0

    for digit in s:gmatch "." do
      if digit ~= " " then
        local num = tonumber(digit)
        if not num then return false end

        num = double and (num == 9 and 9 or (num * 2) % 9) or num
        double = not double
        sum = sum + num
      end
    end
    return sum % 10 == 0
  end,
}
