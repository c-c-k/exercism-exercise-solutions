-- selene: allow(incorrect_standard_library_use)
local unpack = unpack or table.unpack
local MIN_NUM = 1
local MAX_NUM = 9

local function find_combinations(num, sum, size, tested, excluded, found)
  -- overflow base cases
  if num > MAX_NUM or sum < num or size < 1 then return end

  -- currently tested combination success or fail base case
  -- this is a slight optimization to avoid testing all intermediate numbers from the current number to the remaining sum when there is only one slot left open in the combination and thus all the intermediate numbers would be disqualified.
  if size == 1 then
    if sum <= MAX_NUM and not excluded[sum] then
      table.insert(tested, sum)
      table.insert(found, { unpack(tested) })
      table.remove(tested)
    end

    return
  end

  -- test combination with num recursive case
  if not excluded[num] then
    table.insert(tested, num)
    find_combinations(num + 1, sum - num, size - 1, tested, excluded, found)
    table.remove(tested)
  end
  -- test combination without num recursive case
  -- slight optimization with tail call
  return find_combinations(num + 1, sum, size, tested, excluded, found)
end

local function combinations(sum, size, exclude)
  local found = {}
  local excluded = {}

  for _, num in ipairs(exclude or {}) do
    excluded[num] = true
  end

  find_combinations(MIN_NUM, sum, size, {}, excluded, found)

  return found
end

return { combinations = combinations }
