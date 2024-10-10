local LETTER_VALUES = {}

local f = io.open("./letter_values_map.txt", "r")
if f then
  for letters, value in f:read("*a"):gmatch "| (%u%U.-) | (%d+)%s+|" do
    for letter in letters:gmatch "%u" do
      LETTER_VALUES[letter] = value
    end
  end
  f:close()
else
  error "Can't find ./letter_values_map.txt"
end

local function score(word)
  if not word then return 0 end

  local _score = 0

  for letter in word:upper():gmatch "." do
    _score = _score + LETTER_VALUES[letter]
  end

  return _score
end

return { score = score }
