-- NOTE: Comparison of the different implementations
-- Results:
-- ./series.lua: 0.735022 s
-- ./series-complex-iterator.lua: 0.981685 s
-- ./series-coroutine.lua: 1.224899 s

local AVERAGE_COUNT = 3
local REPEATS = 10 ^ 6
local implementations =
{ "./series.lua", "./series-complex-iterator.lua", "./series-coroutine.lua" }
for _, implementation in ipairs(implementations) do
  local test = dofile(implementation)
  local sum = 0

  for _ = 1, AVERAGE_COUNT do
    local t0 = os.clock()
    for _ = 1, REPEATS do
      for _ in test(string.rep("abc", 1), 1) do
        if false then break end
      end
    end
    sum = sum + os.clock() - t0
  end
  print(("%s: %f s"):format(implementation, sum / AVERAGE_COUNT))
end
