local ALPHABET_LEN = 26
local ENCODE_SPACE_INTERVAL = 5
local char_to_id = {}
local id_to_char = {}

do
  local byte_a = string.byte "a"
  local byte_A = string.byte "A"
  for i = 0, ALPHABET_LEN - 1 do
    local char = string.char(byte_A + i)
    char_to_id[char] = i
    char = string.char(byte_a + i)
    char_to_id[char] = i
    id_to_char[i] = char
  end
end

local function extract_factor_2(x)
  while x % 2 == 0 do
    x = math.floor(x / 2)
  end

  return x
end

-- Adapted from:
-- <https://en.wikipedia.org/wiki/Binary_GCD_algorithm#Implementation>
local function are_coprime(a, m)
  if a % 2 == 0 and m % 2 == 0 then return false end

  a = extract_factor_2(a)
  while true do
    m = extract_factor_2(m)
    if a > m then
      a, m = m, a
    end
    m = m - a
    if m == 0 then return a == 1 end
  end
end

local function validate_coprime(a, m)
  if not are_coprime(a, m) then error("a and m must be coprime.", 3) end
end

-- Adapted from naive approach from:
-- <https://www.geeksforgeeks.org/multiplicative-inverse-under-modulo-m/>
local function get_mmi(a, m)
  a = a % m
  for x = 0, m - 1 do
    if (a * x) % m == 1 then return x end
  end
end

local function encode_char(c, a, b, m)
  local i = char_to_id[c]
  if i then
    i = (a * i + b) % m
    c = id_to_char[i]
  end
  return c
end

local function encode(phrase, key)
  local a, b, m = key["a"], key["b"], ALPHABET_LEN
  validate_coprime(a, m)

  local result = {}
  local to_space = ENCODE_SPACE_INTERVAL

  for char in phrase:gmatch "[%a%d]" do
    if to_space == 0 then
      table.insert(result, " ")
      to_space = ENCODE_SPACE_INTERVAL
    end

    table.insert(result, encode_char(char, a, b, m))
    to_space = to_space - 1
  end

  return table.concat(result)
end

local function decode_char(c, mmi, b, m)
  local i = char_to_id[c]
  if i then
    i = mmi * (i - b) % m
    c = id_to_char[i]
  end
  return c
end

local function decode(phrase, key)
  local a, b, m = key["a"], key["b"], ALPHABET_LEN
  validate_coprime(a, m)

  local mmi = get_mmi(a, m)
  local result = {}

  for char in phrase:gmatch "[%a%d]" do
    table.insert(result, decode_char(char, mmi, b, m))
  end

  return table.concat(result)
end

return { encode = encode, decode = decode }
