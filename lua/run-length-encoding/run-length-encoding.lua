return {
  encode = function(s)
    repeat
      local run_start = s:find '(%D)%1'
      if not run_start then break end

      local char = s:sub(run_start, run_start)
      s = s:gsub(char:rep(2) .. '+', function(run)
        return tostring(#run) .. char
      end)
    until false

    return s
  end,

  decode = function(s)
    local decoded = s:gsub('(%d+)(%D)', function(count, char)
      return char:rep(tonumber(count))
    end)

    return decoded
  end,
}
