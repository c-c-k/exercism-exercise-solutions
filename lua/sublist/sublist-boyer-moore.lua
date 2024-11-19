-- NOTE:Boyer-Moore Algorithm
-- <https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_string-search_algorithm>
-- <https://www.geeksforgeeks.org/boyer-moore-algorithm-for-pattern-searching/>
-- <https://www.geeksforgeeks.org/boyer-moore-algorithm-good-suffix-heuristic/>
-- **The following site seems to be AI generated content**
-- <https://www.codingdrills.com/tutorial/introduction-to-searching-algorithms/sublist-search-python>

local function build_bad_char_table(sublist, sublist_length)
  local bad_char_table = {}

  for i = 1, sublist_length do
    bad_char_table[sublist[i]] = i
  end

  return bad_char_table
end

local function preprocess_general_case(
  good_suffix_table,
  borders,
  sublist,
  sublist_length
)
  local position = sublist_length + 1
  local border = sublist_length + 2
  borders[position] = border

  while position > 1 do
    while
      border <= sublist_length + 1
      and sublist[position - 1] ~= sublist[border - 1]
    do
      if good_suffix_table[border] == 0 then
        good_suffix_table[border] = border - position
      end

      border = borders[border]
    end

    position = position - 1
    border = border - 1
    borders[position] = border
  end
end

local function preprocess_fallback_case(
  good_suffix_table,
  borders,
  _,
  sublist_length
)
  local border = borders[1]

  for position = 1, sublist_length + 1 do
    if good_suffix_table[position] == 0 then
      good_suffix_table[position] = border - 1
    end

    if position == border then border = borders[border] end
  end
end

local function build_good_suffix_table(sublist, sublist_length)
  local borders = {}
  local good_suffix_table = {}
  for i = 1, sublist_length + 1 do
    borders[i] = 0
    good_suffix_table[i] = 0
  end

  preprocess_general_case(good_suffix_table, borders, sublist, sublist_length)
  preprocess_fallback_case(good_suffix_table, borders, sublist, sublist_length)

  return good_suffix_table
end

return function(sublist, list)
  if #sublist == 0 then return true, {} end

  local matches = {}

  local list_length = #list
  local sublist_length = #sublist
  local bad_char_table = build_bad_char_table(sublist, sublist_length)
  local good_suffix_table = build_good_suffix_table(sublist, sublist_length)

  local match_end = sublist_length
  local bad_char_skip, good_suffix_skip

  while match_end <= list_length do
    local sublist_index = sublist_length
    local list_index = match_end

    while sublist_index >= 1 and list[list_index] == sublist[sublist_index] do
      sublist_index = sublist_index - 1
      list_index = list_index - 1
    end

    if sublist_index < 1 then
      matches[#matches + 1] = list_index + 1

      bad_char_skip = sublist_length
        - (bad_char_table[list[match_end + 1]] or 0)
        + 1
      good_suffix_skip = good_suffix_table[1]
    else
      -- MEMO: Compensation for the possibility of bad_char_skip resolving to a negative shift is done later when selecting between bad_char_skip and good_suffix_skip (which would always be a positive shift)
      bad_char_skip = sublist_index - (bad_char_table[list[list_index]] or 0)
      good_suffix_skip = good_suffix_table[sublist_index + 1]
    end

    match_end = match_end + math.max(bad_char_skip, good_suffix_skip)
  end

  return #matches > 0, matches
end
