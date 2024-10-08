local function clean(num)
  local cleaned = num:gsub("%D", ""):match "^1?([2-9]%d%d[2-9]%d%d%d%d%d%d)$"

  return cleaned or ("0"):rep(10)
end

local PhoneNumber = {
  new = function(_, raw_number)
    local cleaned_number = clean(raw_number)
    local phone = setmetatable({
      number = cleaned_number,
      areaCode = function() return cleaned_number:sub(1, 3) end,
    }, {
      __tostring = function()
        return ("(%s) %s-%s"):format(cleaned_number:match "(...)(...)(....)")
      end,
    })

    return phone
  end,
}

return PhoneNumber
