local EliudsEggs = {}

function EliudsEggs.egg_count(number)
    local num_eggs = 0
    while number > 0 do
        if number % 2 == 1 then
            num_eggs = num_eggs + 1
        end
        number = math.floor(number / 2)
    end
    return num_eggs
end

return EliudsEggs
