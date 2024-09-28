-- selene: allow(incorrect_standard_library_use)
local unpack = unpack or table.unpack

local __VERSE_TEMPLATE = [[
%s green %s hanging on the wall,
%s green %s hanging on the wall,
And if one green bottle should accidentally fall,
There'll be %s green %s hanging on the wall.
]]
local _VERSE_KEY_WORDS = {
  { 'One', 'bottle', 'no', 'bottles' },
  { 'Two', 'bottles', 'one', 'bottle' },
  { 'Three', 'bottles', 'two', 'bottles' },
  { 'Four', 'bottles', 'three', 'bottles' },
  { 'Five', 'bottles', 'four', 'bottles' },
  { 'Six', 'bottles', 'five', 'bottles' },
  { 'Seven', 'bottles', 'six', 'bottles' },
  { 'Eight', 'bottles', 'seven', 'bottles' },
  { 'Nine', 'bottles', 'eight', 'bottles' },
  { 'Ten', 'bottles', 'nine', 'bottles' },
}

local function get_verse(verse_num)
  local current_count, bottles_start, next_count, bottles_end =
    unpack(_VERSE_KEY_WORDS[verse_num])

  return __VERSE_TEMPLATE:format(
    current_count,
    bottles_start,
    current_count,
    bottles_start,
    next_count,
    bottles_end
  )
end

local BottleSong = {}

function BottleSong.recite(start_bottles, take_down)
  local verses = {}

  for verse_num = start_bottles, start_bottles - take_down + 1, -1 do
    table.insert(verses, get_verse(verse_num))
  end

  return table.concat(verses, '\n')
end

return BottleSong
