local _BASE = 'abcdefghijklmnopqrstuvwxyz0123456789'
local _CODE = 'zyxwvutsrqponmlkjihgfedcba0123456789'
local map = {}
for i = 1, #_BASE do
  map[_BASE:sub(i, i)] = _CODE:sub(i, i)
end

return {
  encode = function(plaintext)
    local ciphertext = plaintext:lower()
    local count = 0

    return ciphertext:gsub('.', function(char)
      if not map[char] then return '' end
      if count == 5 then
        count = 1
        return ' ' .. map[char]
      else
        count = count + 1
        return map[char]
      end
    end)
  end,
}
