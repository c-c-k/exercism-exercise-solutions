local PATTERN_BODY = "For want of a %s the %s was lost.\n"
local PATTERN_TAIL = "And all for the want of a %s.\n"

local Proverb = {}

function Proverb.recite(strings)
  if #strings == 0 then return "" end

  local proverb = {}

  for i = 2, #strings do
    proverb[#proverb + 1] = PATTERN_BODY:format(strings[i - 1], strings[i])
  end
  proverb[#proverb + 1] = PATTERN_TAIL:format(strings[1])

  return table.concat(proverb)
end

return Proverb
