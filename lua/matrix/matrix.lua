return function(s)
  local matrix = {}
  matrix._rows = {}
  matrix._columns = {}

  for line in s:gmatch '[^\r\n]+' do
    local row = {}
    for str_value in line:gmatch '%d+' do
      table.insert(row, tonumber(str_value))
    end
    table.insert(matrix._rows, row)
  end

  for _ in ipairs(matrix._rows[1]) do
    table.insert(matrix._columns, {})
  end
  for row, values in ipairs(matrix._rows) do
    for column, value in ipairs(values) do
      matrix._columns[column][row] = value
    end
  end

  matrix.row = function(n)
    return matrix._rows[n]
  end
  matrix.column = function(n)
    return matrix._columns[n]
  end
  return matrix
end
