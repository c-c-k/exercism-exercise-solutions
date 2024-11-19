-- NOTE:KMP algorithm
-- <https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm>
-- <https://www.geeksforgeeks.org/kmp-algorithm-for-pattern-searching/>
-- **The following site seems to be AI generated content**
-- <https://www.codingdrills.com/tutorial/introduction-to-searching-algorithms/sublist-search-python>

local function build_partial_match_table(sublist, sublist_length)
  local partial_match_table = { 0 }
  local candidate = 1

  for position = 2, sublist_length do
    if sublist[position] == sublist[candidate] then
      partial_match_table[position] = partial_match_table[candidate]
    else
      partial_match_table[position] = candidate
      while candidate >= 1 and sublist[position] ~= sublist[candidate] do
        candidate = partial_match_table[candidate]
      end
    end
    candidate = candidate + 1
  end

  partial_match_table[#partial_match_table + 1] = candidate
  return partial_match_table
end

return function(sublist, list)
  if #sublist == 0 then return true, {} end

  local matches = {}

  local list_length = #list
  local sublist_length = #sublist
  local partial_match_table = build_partial_match_table(sublist, sublist_length)

  local position, match_start = 1, 1

  while position <= list_length do
    if sublist[match_start] == list[position] then
      position = position + 1
      match_start = match_start + 1
      if match_start > sublist_length then
        matches[#matches + 1] = position - match_start + 1
        match_start = partial_match_table[match_start]
      end
    else
      match_start = partial_match_table[match_start]
      if match_start == 0 then
        position = position + 1
        match_start = match_start + 1
      end
    end
  end

  return #matches > 0, matches
end
