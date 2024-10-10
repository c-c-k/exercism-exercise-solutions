local ACTIONS = { "wink", "double blink", "close your eyes", "jump" }

return function(n)
  local actions = {}
  local reverse = n >= 16

  for _, action in ipairs(ACTIONS) do
    if n % 2 == 1 then
      if reverse then
        table.insert(actions, 1, action)
      else
        table.insert(actions, action)
      end
    end
    n = math.floor(n / 2)
  end

  return actions
end
