local triangle = {}

function triangle.kind(a, b, c)
    assert(a ~= 0, "Input Error")
    assert(b ~= 0, "Input Error")
    assert(c ~= 0, "Input Error")
    assert(a + b >= c, "Input Error")
    assert(b + c >= a, "Input Error")
    assert(a + c >= b, "Input Error")

    if a == b and a == c then
        return "equilateral"
    elseif a == b or b == c or a == c then
        return "isosceles"
    else
        return "scalene"
    end
end

return triangle
