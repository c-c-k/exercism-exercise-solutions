local function filter(xs, pred, keep)
  local filtered = {}
  for _, item in ipairs(xs) do
    local match = pred(item)
    if keep and match or not (keep or match) then
      table.insert(filtered, item)
    end
  end
  return filtered
end

local function keep(xs, pred)
  return filter(xs, pred, true)
end

local function discard(xs, pred)
  return filter(xs, pred, false)
end

return { keep = keep, discard = discard }
