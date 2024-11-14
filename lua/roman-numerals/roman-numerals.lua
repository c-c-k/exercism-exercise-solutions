local ROMAN_NUMERALS = {
  { value = 1000, numeral = "M" },
  { value = 900,  numeral = "CM" },
  { value = 500,  numeral = "D" },
  { value = 400,  numeral = "CD" },
  { value = 100,  numeral = "C" },
  { value = 90,   numeral = "XC" },
  { value = 50,   numeral = "L" },
  { value = 40,   numeral = "XL" },
  { value = 10,   numeral = "X" },
  { value = 9,    numeral = "IX" },
  { value = 5,    numeral = "V" },
  { value = 4,    numeral = "IV" },
  { value = 1,    numeral = "I" },
}

return {
  to_roman = function(n)
    if n > 3999 then
      error("Only traditional Roman numerals up to 3,999 are supported", 2)
    end

    local converted = {}

    for _, roman_numeral in ipairs(ROMAN_NUMERALS) do
      while n >= roman_numeral.value do
        converted[#converted + 1] = roman_numeral.numeral
        n = n - roman_numeral.value
      end
    end

    return table.concat(converted, "")
  end,
}
