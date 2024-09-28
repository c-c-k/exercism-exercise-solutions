local unpack = unpack or table.unpack
local byte_a = 65
local byte_A = 97
local alphabet_len = 26

return {
  rotate = function(input, key)
    local encode_map = {}
    for i = 0, alphabet_len - 1 do
      encode_map[byte_a + i] = byte_a + (i + key) % alphabet_len
      encode_map[byte_A + i] = byte_A + (i + key) % alphabet_len
    end

    local bytes = { input:byte(1, #input) }
    for i = 1, #bytes do
      local byte = bytes[i]
      bytes[i] = byte and encode_map[byte] or byte
    end

    return string.char(unpack(bytes))
  end,
}
