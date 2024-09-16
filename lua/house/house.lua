local house = {}

local function split_into_lines(input)
  local lines = {}
  for line in input:gmatch '[^\r\n]+' do
    table.insert(lines, line)
  end
  return lines
end

local full_verse_lines = split_into_lines [[
This is the horse and the hound and the horn
that belonged to the farmer sowing his corn
that kept the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.
]]

house.verse = function(which)
  -- determine the index of the first line for the current verse
  local first_line_index = #full_verse_lines - which + 1

  -- Concat verse lines
  local verse = table.concat(full_verse_lines, '\n', first_line_index)

  -- Replace first line action with "this is "
  local replacement_index = assert(verse:find 'the')
  verse = 'This is ' .. verse:sub(replacement_index)

  return verse
end

house.recite = function()
  local song = house.verse(1)
  for i = 2, #full_verse_lines do
    song = song .. '\n' .. house.verse(i)
  end
  return song
end

return house
