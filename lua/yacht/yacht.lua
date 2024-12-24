local function score_side(dice, side)
  local score = 0
  for _, roll in ipairs(dice) do
    score = score + (roll == side and side or 0)
  end
  return score
end

local function count_two_sides(dice)
  local side_a, count_a = dice[1], 1
  local side_b, count_b

  for i = 2, 5 do
    local roll = dice[i]
    if roll == side_a then
      count_a = count_a + 1
    elseif not side_b then
      side_b, count_b = roll, 1
    elseif roll == side_b then
      count_b = count_b + 1
    else
      return nil, nil, nil, nil
    end
  end

  return side_a, count_a, side_b, count_b
end

local function score_full_house(dice)
  local side_a, count_a, side_b, count_b = count_two_sides(dice)
  if not (count_a == 3 or count_b == 3) then return 0 end
  return count_a * side_a + count_b * side_b
end

local function score_four_of_a_kind(dice)
  local side_a, count_a, side_b, count_b = count_two_sides(dice)
  if not (count_a >= 4 or count_b >= 4) then return 0 end
  return count_a >= 4 and 4 * side_a or 4 * side_b
end

local function score_straight(dice, is_big)
  local prev_rolls = {}
  for _, roll in ipairs(dice) do
    if
        prev_rolls[roll]
        or (is_big and roll == 1)
        or (not is_big and roll == 6)
    then
      return 0
    end

    prev_rolls[roll] = true
  end

  return 30
end

local function score_choice(dice)
  local score = 0
  for _, roll in ipairs(dice) do
    score = score + roll
  end
  return score
end

local function score_yacht(dice)
  local side = dice[1]
  for i = 2, 5 do
    if dice[i] ~= side then return 0 end
  end
  return 50
end

local score_category = {
  ["ones"] = function(dice) return score_side(dice, 1) end,
  ["twos"] = function(dice) return score_side(dice, 2) end,
  ["threes"] = function(dice) return score_side(dice, 3) end,
  ["fours"] = function(dice) return score_side(dice, 4) end,
  ["fives"] = function(dice) return score_side(dice, 5) end,
  ["sixes"] = function(dice) return score_side(dice, 6) end,
  ["full house"] = function(dice) return score_full_house(dice) end,
  ["four of a kind"] = function(dice) return score_four_of_a_kind(dice) end,
  ["little straight"] = function(dice) return score_straight(dice, false) end,
  ["big straight"] = function(dice) return score_straight(dice, true) end,
  ["choice"] = function(dice) return score_choice(dice) end,
  ["yacht"] = function(dice) return score_yacht(dice) end,
}

return {
  score = function(dice, category) return score_category[category](dice) end,
}
