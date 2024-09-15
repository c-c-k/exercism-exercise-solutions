return function(n)
    assert(n > 0, "Only positive numbers are allowed")
    local steps = 0
    while n ~= 1 do
        steps = steps + 1
        n = n % 2 == 0 and n / 2 or 3 * n + 1
    end
    return steps
end
