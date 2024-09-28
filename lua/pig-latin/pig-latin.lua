local unpack = unpack or table.unpack
local _VOWELS = 'aeiou'
local _CONSONANTS = 'bcdfghjklmnpqrstvwxyz'

local rules = {
  --  rule 1 pattern 1
  { '%1ay',   ('^[%s]%%a+'):format(_VOWELS) },
  --  rule 1 pattern 2
  { '%1ay',   '^xr%a+' },
  --  rule 1 pattern 3
  { '%1ay',   '^yt%a+' },
  --  rule 3 pattern
  { '%2%1ay', ('^([%s]*qu)(%%a+)$'):format(_CONSONANTS) },
  --  rule 4 pattern
  { '%2%1ay', ('^([%s]+)(y%%a+)$'):format(_CONSONANTS) },
  --  rule 2 pattern
  { '%2%1ay', ('^([%s]+)(%%a+)$'):format(_CONSONANTS) },
}

local function translate_word(word)
  for _, rule in ipairs(rules) do
    local substitution, pattern = unpack(rule)
    local new_word, replacements = word:gsub(pattern, substitution)
    if replacements > 0 then return new_word end
  end
  return word
end

local function translate_phrase(phrase)
  local words = {}
  for word in phrase:gmatch '%a+' do
    table.insert(words, translate_word(word))
  end
  return table.concat(words, ' ')
end

return translate_phrase
