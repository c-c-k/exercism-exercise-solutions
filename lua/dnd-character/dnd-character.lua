---Simulate 4 rolls of a six sided dice
---@return integer[]
local function roll_dice()
  return {
    math.random(6),
    math.random(6),
    math.random(6),
    math.random(6),
  }
end

---Determines final ability score
---
---Final ability score is average of best 3 of 4 scores ([dnd: determining ability scores](https://en.wikipedia.org/wiki/Dungeons_%26_Dragons_gameplay#Determining_ability_scores))
---@param scores integer[]
---@return integer
local function ability(scores)
  table.sort(scores, function(a, b) return a > b end)
  return scores[1] + scores[2] + scores[3]
end

---Calculate an ability modifier
---
---Ability modifier formula is (score - 10)/2 ([dnd: ability modifiers](https://en.wikipedia.org/wiki/Dungeons_%26_Dragons_gameplay#Ability_modifiers))
---@param score integer
---@return integer
local function modifier(score) return math.floor((score - 10) / 2) end

---@class Character
---@field name string
---@field strength integer
---@field dexterity integer
---@field constitution integer
---@field intelligence integer
---@field wisdom integer
---@field charisma integer
---@field hitpoints integer
local Character = {}

---Creates a new character object
---@param name string The name of the new character
---@return Character
function Character:new(name)
  local o = setmetatable({}, self)
  self.__index = self
  o:__init(name)
  return o
end

function Character:__init(name)
  self.name = name
  self.strength = ability(roll_dice())
  self.dexterity = ability(roll_dice())
  self.constitution = ability(roll_dice())
  self.intelligence = ability(roll_dice())
  self.wisdom = ability(roll_dice())
  self.charisma = ability(roll_dice())
  self.hitpoints = 10 + modifier(self.constitution)
end

---@class DND
local M = {
  ability = ability,
  roll_dice = roll_dice,
  modifier = modifier,
  Character = Character,
}

return M
