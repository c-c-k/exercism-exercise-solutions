---@alias etl_old_format table<integer, string[]>
---@alias etl_new_format table<string, integer>
---@class ETL
local M = {
  ---Perform a key-value inversion on the letter values dataset.
  ---@param dataset etl_old_format
  ---@return etl_new_format
  transform = function(dataset)
    ---@type etl_new_format
    local transformed = {}
    for value, letters in pairs(dataset) do
      for _, letter in ipairs(letters) do
        transformed[letter:lower()] = value
      end
    end
    return transformed
  end,
}

return M
