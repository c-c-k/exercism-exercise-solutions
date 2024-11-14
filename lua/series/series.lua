-- NOTE: Solution using simple iterator

return function(s, length)
  local current_offset, max_offset = 0, #s - length + 1

  return function()
    current_offset = current_offset + 1

    if current_offset <= max_offset then
      return s:sub(current_offset, current_offset + length - 1)
    end
  end
end
