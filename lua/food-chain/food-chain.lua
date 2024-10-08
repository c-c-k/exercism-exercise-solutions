---A collection of methods to generate the lyrics of the song:
---[I Know an Old Lady Who Swallowed a Fly](https://en.wikipedia.org/wiki/There_Was_an_Old_Lady_Who_Swallowed_a_Fly)
---@class FoodChain
local M = {}

local FIRST_LINE = "I know an old lady who swallowed a %s."
local MIDDLE_LINE = "She swallowed the %s to catch the %s%s."
local LAST_LINE = "I don't know why she swallowed the fly. Perhaps she'll die."
local SPIDER_ENDING = "wriggled and jiggled and tickled inside her"
local FIRST_VERSE_ID = 1
local LAST_VERSE_ID = 8

---@class AnimalData
---@field name string The name of the new animal being introduced
---@field desc string? description of the old lady swallowing the new animal
---@field desc2 string? description of the new animal swallowing the previous animal

---@type AnimalData[]
local VERSES = {
  { name = "fly" },
  { name = "spider", desc = ("It %s."):format(SPIDER_ENDING) },
  {
    name = "bird",
    desc = "How absurd to swallow a bird!",
    desc2 = (" that %s"):format(SPIDER_ENDING),
  },
  { name = "cat", desc = "Imagine that, to swallow a cat!" },
  { name = "dog", desc = "What a hog, to swallow a dog!" },
  { name = "goat", desc = "Just opened her throat and swallowed a goat!" },
  { name = "cow", desc = "I don't know how she swallowed a cow!" },
  { name = "horse", desc = "She's dead, of course!" },
}

---Generates a single verse from the song
---@param which integer
function M.verse(which)
  local verse_lines = {
    FIRST_LINE:format(VERSES[which].name),
    VERSES[which].desc,
  }

  if which ~= LAST_VERSE_ID then
    for verse = which, FIRST_VERSE_ID + 1, -1 do
      table.insert(
        verse_lines,
        MIDDLE_LINE:format(
          VERSES[verse].name,
          VERSES[verse - 1].name,
          VERSES[verse].desc2 or ""
        )
      )
    end

    table.insert(verse_lines, LAST_LINE)
  end

  return table.concat(verse_lines, "\n") .. "\n"
end

---Generates a given range of verses from the song
---@param from integer
---@param to integer
---@return string
function M.verses(from, to)
  local verses = {}
  for i = from, to do
    table.insert(verses, M.verse(i))
  end
  return table.concat(verses, "\n") .. "\n"
end

---Generates all verses of the song
---@return string
function M.sing() return M.verses(FIRST_VERSE_ID, LAST_VERSE_ID) end

return M
