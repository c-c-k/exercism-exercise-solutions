-- NOTE: Linear brute force algorithm

return function(sublist, list)
  if #sublist == 0 then return true, {} end

  local matches = {}

  for i = 0, #list - #sublist do
    local sublist_matched = true

    for j = 1, #sublist do
      if sublist[j] ~= list[i + j] then
        sublist_matched = false
        break
      end
    end

    if sublist_matched then matches[#matches + 1] = i + 1 end
  end

  return #matches > 0, matches
end
