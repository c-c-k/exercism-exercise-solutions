return function(s)
  s = s:lower()
  local cleared_chars = ''
  local is_isogram = true

  for char in s:gmatch '[^ -]' do
    if cleared_chars:find(char) then
      is_isogram = false
      break
    end
    cleared_chars = cleared_chars .. char
  end

  return is_isogram
end
