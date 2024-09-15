local SquareRoot = {}

local required_precision = 3
local function round(num, precision)
    local rounded = math.floor(num * 10 ^ (precision + 1))
    local round_decider = rounded % 10
    rounded = math.floor(rounded / 10)
    if round_decider > 5 then
        rounded = rounded + 1
    end
    return rounded / 10 ^ precision
end

function SquareRoot.square_root(radicand, estimate)
    -- Set test precision to be 1 more than required precision
    local test_precision = required_precision + 1
    -- Initialize estimate for first recursion level
    if estimate == nil then
        estimate = 2
    end

    -- Create new_estimate for the square_root according to Heron's
    -- method
    -- <https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Heron's_method>
    local new_estimate = (estimate + radicand / estimate) / 2

    -- Check that at the test precision the input estimate is the same as the new_estimate
    if round(estimate, test_precision) == round(new_estimate, test_precision) then
        -- If true return new_estimate as final square_root estimation rounde to the required precision
        return round(new_estimate, required_precision)
    else
        -- Else return better estimation of the square_root
        return SquareRoot.square_root(radicand, new_estimate)
    end
end

return SquareRoot
