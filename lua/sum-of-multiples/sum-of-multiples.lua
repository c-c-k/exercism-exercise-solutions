return function(numbers)
  return {
    to = function(limit)
      table.sort(numbers)
      local multiples = {}
      local sum = 0

      for _, number in ipairs(numbers) do
        if not multiples[number] then
          for multiple = number, limit - 1, number do
            multiples[multiple] = true
          end
        end
      end

      for multiple in pairs(multiples) do
        sum = sum + multiple
      end

      return sum
    end,
  }
end
