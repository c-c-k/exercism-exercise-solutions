local unpack = _VERSION < 'Lua 5.2' and unpack or table.unpack
local HighScores = setmetatable({}, {
  __call = function(self, scores, _)
    self._scores = scores or {}
    return self
  end,
})

local function _top_scores(scores, num)
  local top_scores = {}
  if num == 1 then return { math.max(unpack(scores)) } end
  for _, score in ipairs(scores) do
    local score_index = 1

    while
      top_scores[score_index]
      and score_index < num
      and top_scores[score_index] >= score
    do
      score_index = score_index + 1
    end

    local last_shift_index = #top_scores < num and #top_scores + 1 or num
    for i = last_shift_index, score_index, -1 do
      top_scores[i] = top_scores[i - 1]
    end

    top_scores[score_index] = score
  end
  return top_scores
end

function HighScores:scores()
  return self._scores
end

function HighScores:latest()
  return self._scores[#self._scores]
end

function HighScores:personal_best()
  return _top_scores(self._scores, 3)[1]
end

function HighScores:personal_top_three()
  return _top_scores(self._scores, 3)
end

return HighScores
