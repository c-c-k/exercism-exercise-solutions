-- NOTE: Solution using complex state iterator.
-- NOTE: According to Lua docs this is less efficient than
--  a simple iterator as a table is costlier than a closure.

return function(input, length)
  local init_state = {
    input = input,
    current_offset = 0,
    max_offset = #input - length + 1,
    length_offset = length - 1,
  }

  local function iter(state)
    state.current_offset = state.current_offset + 1

    if state.current_offset <= state.max_offset then
      return input:sub(
        state.current_offset,
        state.current_offset + state.length_offset
      )
    end
  end
  return iter, init_state
end
