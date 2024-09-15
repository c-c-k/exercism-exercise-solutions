local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
    local num_to_proc = number
    local num_to_test = 0
    local digits = {}
    repeat
        table.insert(digits, 1, num_to_proc % 10)
        num_to_proc = math.floor(num_to_proc / 10)
    until num_to_proc == 0

    for _, digit in pairs(digits) do
        num_to_test = num_to_test + digit ^ #digits
    end
    return num_to_test == number
end

return ArmstrongNumbers
