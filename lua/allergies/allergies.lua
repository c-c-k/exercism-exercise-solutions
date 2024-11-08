local ALLERGIES = {
  "eggs",
  "peanuts",
  "shellfish",
  "strawberries",
  "tomatoes",
  "chocolate",
  "pollen",
  "cats",
}
local allergie_ids = {}
for index, allergie in ipairs(ALLERGIES) do
  allergie_ids[allergie] = index
end

local function list(score)
  local allergies_list = {}

  for _, allergie in ipairs(ALLERGIES) do
    if score % 2 == 1 then table.insert(allergies_list, allergie) end
    score = math.floor(score / 2)
  end

  return allergies_list
end

local function allergic_to(score, which)
  local allergie_id = allergie_ids[which]
  return (math.floor(score / 2 ^ (allergie_id - 1))) % 2 == 1
end

return { list = list, allergic_to = allergic_to }
