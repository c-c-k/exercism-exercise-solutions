local leap_year = function(number)
    local is_div4 = number % 4 == 0
    local is_div100 = number % 100 == 0
    local is_div400 = number % 400 == 0
    return is_div400 or (not is_div100 and is_div4)
end

return leap_year
