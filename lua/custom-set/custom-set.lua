local _sets = setmetatable({}, {
  __mode = 'k',
  __tostring = function(t)
    local str_sets = {}
    for k, _ in pairs(t) do
      table.insert(str_sets, tostring(k))
    end
    return table.concat(str_sets, ' ; ')
  end,
})
local Set = {}
Set.__index = Set
Set.__newindex = function()
  error 'Direct manipulation of set elements is forbidden, use add/remove methods'
end

setmetatable(Set, {
  __call = function(cls, ...)
    local new_set = setmetatable({}, cls)
    new_set:_init(...)
    return new_set
  end,
})

function Set:_init(...)
  _sets[self] = {}
  _sets[self]._cardinality = 0
  _sets[self]._elements = {}
  for _, element in ipairs { ... } do
    self:add(element)
  end
end

function Set:toarray()
  local array = {}
  for element, _ in pairs(_sets[self]._elements) do
    table.insert(array, element)
  end
  return array
end

function Set:add(element)
  if not _sets[self]._elements[element] then
    _sets[self]._cardinality = _sets[self]._cardinality + 1
    _sets[self]._elements[element] = true
  end
end

function Set:remove(element)
  if _sets[self]._elements[element] then
    _sets[self]._cardinality = _sets[self]._cardinality - 1
    _sets[self]._elements[element] = nil
  end
end

function Set:is_empty()
  return _sets[self]._cardinality == 0
end

function Set:contains(element)
  return _sets[self]._elements[element] == true
end

function Set:is_subset(other)
  for element, _ in pairs(_sets[self]._elements) do
    if not other:contains(element) then return false end
  end
  return true
end

function Set:is_proper_subset(other)
  return _sets[self]._cardinality < _sets[other]._cardinality
      and self:is_subset(other)
end

function Set:equals(other)
  return _sets[self]._cardinality == _sets[other]._cardinality
      and self:is_subset(other)
end

function Set:is_disjoint(other)
  if self:is_empty() or other:is_empty() then return true end
  for element, _ in pairs(_sets[self]._elements) do
    if other:contains(element) then return false end
  end
  return true
end

function Set:intersection(other)
  local new_set = Set()
  for element, _ in pairs(_sets[self]._elements) do
    if other:contains(element) then new_set:add(element) end
  end
  return new_set
end

function Set:difference(other)
  local new_set = Set()
  for element, _ in pairs(_sets[self]._elements) do
    if not other:contains(element) then new_set:add(element) end
  end
  return new_set
end

function Set:symmetric_difference(other)
  local new_set = Set()
  for element, _ in pairs(_sets[self]._elements) do
    if not other:contains(element) then new_set:add(element) end
  end
  for element, _ in pairs(_sets[other]._elements) do
    if not self:contains(element) then new_set:add(element) end
  end
  return new_set
end

function Set:union(other)
  local new_set = Set()
  for element, _ in pairs(_sets[self]._elements) do
    new_set:add(element)
  end
  for element, _ in pairs(_sets[other]._elements) do
    new_set:add(element)
  end
  return new_set
end

Set.__eq = Set.equals
Set.__le = Set.is_subset
Set.__lt = Set.is_proper_subset
Set.__add = Set.union
Set.__sub = Set.difference
Set.__mod = Set.intersection
Set.__pow = Set.symmetric_difference
Set.__tostring = function(self)
  return ('{ %s }'):format(table.concat(self:toarray(), ', '))
end

return Set
