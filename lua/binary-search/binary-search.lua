local function lua51_table_length(t)
  local mt = getmetatable(t)
  if mt and mt.__len then
    return mt.__len(t)
  else
    return #t
  end
end

return function(array, target)
  local bottom, top = 1, lua51_table_length(array)

  local middle, test_value
  while bottom <= top do
    middle = math.floor((bottom + top) / 2)
    test_value = array[middle]
    if test_value == target then
      break
    elseif test_value > target then
      top = middle - 1
    else
      bottom = middle + 1
    end
  end

  return bottom <= top and middle or -1
end
