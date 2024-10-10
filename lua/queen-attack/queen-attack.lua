local function can_attack(q1, q2)
  return q1.row == q2.row
      or q1.column == q2.column
      or math.abs(q1.row - q2.row) == math.abs(q1.column - q2.column)
end

return function(pos)
  if pos.row <= 0 or pos.row >= 7 then error("Illegal row", 2) end
  if pos.column <= 0 or pos.column >= 7 then error("Illegal column", 2) end

  function pos.can_attack(other) return can_attack(pos, other) end

  return pos
end
