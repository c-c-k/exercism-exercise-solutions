local operators = {
  ["What is"] = function(_, operand2) return operand2 end,
  ["plus"] = function(operand1, operand2) return operand1 + operand2 end,
  ["minus"] = function(operand1, operand2) return operand1 - operand2 end,
  ["multiplied by"] = function(operand1, operand2) return operand1 * operand2 end,
  ["divided by"] = function(operand1, operand2) return operand1 / operand2 end,
}

local function answer(question)
  local result, operator, operator_func, operand, last
  last = 0

  while last and last < #question do
    _, last, operator, operand =
        string.find(question, "(%a[%a ]+) (-?%d+)[ ?]", last)

    operator_func = operators[operator]
    if not operator_func then error("Invalid question", 2) end

    operand = tonumber(operand)
    result = operator_func(result, operand)
  end

  if not last then error("Invalid question", 2) end

  return result
end

return { answer = answer }
