-- NOTE: ... Because the problem specification did not require
--  implementing the solution using first principals only 😭
-- <https://exercism.org/tracks/lua/exercises/sublist/solutions/ryanplusplus>

local SEPARATOR = string.char(35)

local function list2string(list)
  return SEPARATOR .. table.concat(list, SEPARATOR) .. SEPARATOR
end

return function(sublist, list)
  if #sublist == 0 then return true, {} end

  local matches = {}

  sublist = list2string(sublist)
  list = list2string(list)
  local match

  while true do
    match = list:find(sublist, match or 1)
    if not match then break end
    matches[#matches + 1] =
      list:sub(1, match):gsub(("[^%s]"):format(SEPARATOR), ""):len()
    match = match + 1
  end

  return #matches > 0, matches
end
