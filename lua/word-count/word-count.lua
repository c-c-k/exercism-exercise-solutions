local function word_count(s)
  local words = {}

  for word in s:lower():gmatch "%w+'?%w*" do
    word = word:gsub("'*$", "")
    words[word] = (words[word] or 0) + 1
  end

  return words
end

return { word_count = word_count }
