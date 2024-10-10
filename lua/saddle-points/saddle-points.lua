local unpack = unpack or table.unpack

return function(matrix)
  local row_count = #matrix
  local column_count = row_count > 0 and #matrix[1] or 0
  if column_count == 0 then return {} end

  local saddle_points = {}
  --- Courtesy to <https://exercism.org/tracks/lua/exercises/saddle-points/solutions/alterpatzer>
  local saddle_height = math.huge
  local saddle_rows = {}

  for row, row_values in ipairs(matrix) do
    local row_max = math.max(unpack(row_values))
    if row_max < saddle_height then
      saddle_height = row_max
      saddle_rows = { row }
    elseif row_max == saddle_height then
      table.insert(saddle_rows, row)
    end
  end

  for column = 1, column_count do
    local is_saddle_colum = true

    for _, row in ipairs(saddle_rows) do
      if matrix[row][column] < saddle_height then
        is_saddle_colum = false
        break
      end
    end

    if is_saddle_colum then
      for _, row in ipairs(saddle_rows) do
        table.insert(saddle_points, { row = row, column = column })
      end
    end
  end

  return saddle_points
end
