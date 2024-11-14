-- NOTE: Solution using coroutine wrap
-- NOTE: According to Lua docs this is less efficient than
--  a simple iterator or a complex state iterator
--  as a coroutine has a significant overhead.

return function(s, length)
  return coroutine.wrap(function()
    for i = 1, (#s - length + 1) do
      coroutine.yield(s:sub(i, i + length - 1))
    end
  end)
end
