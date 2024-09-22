local unpack = _VERSION < 'Lua 5.2' and unpack or table.unpack
return function(which)
  local byte_a = string.byte 'A'
  local diamond = {}

  local len = string.byte(which) - byte_a + 1
  local letter_byte = byte_a
  for row = 1, len do
    local row_bytes = {}
    for col = 1, len * 2 - 1 do
      local is_letter_byte = (math.abs(len - col) + 1 == row)
      row_bytes[col] = is_letter_byte and letter_byte or 32 -- space
    end
    local row_string = string.char(unpack(row_bytes))
    diamond[row] = row_string
    letter_byte = letter_byte + 1
  end

  for row = 1, len - 1 do
    diamond[len * 2 - row] = diamond[row]
  end

  return table.concat(diamond, '\n') .. '\n'
end
