return function(s)
  local found_letters, count = {}, 0
  s = s:lower()
  for letter in s:gmatch "%a" do
    if not found_letters[letter] then
      found_letters[letter] = true
      count = count + 1
    end
    if count == 26 then return true end
  end
  return false
end
