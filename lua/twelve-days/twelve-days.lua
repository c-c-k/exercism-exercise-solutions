local VERSE_TEMPLATE = "On the %s day of Christmas my true love gave to me: %s."
local VERSE_DATA = {
  { day = "first",    gift = "and a Partridge in a Pear Tree" },
  { day = "second",   gift = "two Turtle Doves" },
  { day = "third",    gift = "three French Hens" },
  { day = "fourth",   gift = "four Calling Birds" },
  { day = "fifth",    gift = "five Gold Rings" },
  { day = "sixth",    gift = "six Geese-a-Laying" },
  { day = "seventh",  gift = "seven Swans-a-Swimming" },
  { day = "eighth",   gift = "eight Maids-a-Milking" },
  { day = "ninth",    gift = "nine Ladies Dancing" },
  { day = "tenth",    gift = "ten Lords-a-Leaping" },
  { day = "eleventh", gift = "eleven Pipers Piping" },
  { day = "twelfth",  gift = "twelve Drummers Drumming" },
}

local function get_verse(verse_id)
  local gifts = {}

  if verse_id == 1 then
    gifts = { VERSE_DATA[1].gift:sub(5) }
  else
    for i = verse_id, 1, -1 do
      table.insert(gifts, VERSE_DATA[i].gift)
    end
  end

  return VERSE_TEMPLATE:format(
    VERSE_DATA[verse_id].day,
    table.concat(gifts, ", ")
  )
end

local function recite(start_verse, end_verse)
  local verses = {}

  for verse_id = start_verse, end_verse do
    table.insert(verses, get_verse(verse_id))
  end

  return verses
end

return { recite = recite }
