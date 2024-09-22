local Darts = {}
local rings = { { 1, 10 }, { 5, 5 }, { 10, 1 } }

function Darts.score(x, y)
  local distance = math.sqrt(x ^ 2 + y ^ 2)
  local score = 0
  for _, ring in ipairs(rings) do
    if distance <= ring[1] then
      score = ring[2]
      break
    end
  end

  return score
end

return Darts
