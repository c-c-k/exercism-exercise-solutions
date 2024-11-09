-- NOTE: This version provides a greater level of abstraction,
-- however, since the abstraction only gains 4 abstracted functions
-- for the cost of 2 extra functions, the increased overhead
-- and code complexity don't seem to be a worthwhile trade off.

local function get_ends(from_head)
  if from_head then
    return "_head", "_tail", "next", "prev"
  else
    return "_tail", "_head", "prev", "next"
  end
end

local function insert(linkedlist, value, from_head)
  local side, opposite, direction, reverse = get_ends(from_head)

  local node = { value = value }

  if linkedlist._count == 0 then
    linkedlist[opposite] = node
  else
    node[direction] = linkedlist[side]
    linkedlist[side][reverse] = node
  end

  linkedlist[side] = node
  linkedlist._count = linkedlist._count + 1
end

local function remove(linkedlist, from_head)
  local count = linkedlist._count
  if count == 0 then return end

  local side, opposite, direction, reverse = get_ends(from_head)

  local node = linkedlist[side]

  if count == 1 then
    linkedlist[opposite] = nil
  else
    node[direction][reverse] = nil
  end

  linkedlist[side] = node[direction]
  linkedlist._count = count - 1
  return node.value
end

local function push(linkedlist, value) insert(linkedlist, value, false) end

local function pop(linkedlist) return remove(linkedlist, false) end

local function unshift(linkedlist, value) insert(linkedlist, value, true) end

local function shift(linkedlist) return remove(linkedlist, true) end

local function count(linkedlist) return linkedlist._count end

local function delete(linkedlist, value)
  local node = linkedlist._head

  while node do
    if node.value == value then
      if node.prev then
        node.prev.next = node.next
      else
        linkedlist._head = node.next
      end
      if node.next then
        node.next.prev = node.prev
      else
        linkedlist._tail = node.prev
      end
      linkedlist._count = linkedlist._count - 1
    end

    node = node.next
  end
end

return function()
  return {
    _head = nil,
    _tail = nil,
    _count = 0,
    push = push,
    pop = pop,
    shift = shift,
    unshift = unshift,
    count = count,
    delete = delete,
  }
end
--[[
1. add local function for each function in spec with input (list, [value]).
2. set main function to return table with items: head, tail, count and a reference to each of the required functions in the spec
  - head and tail should start with nil values
  - count should start at 0
3. background logic: each node (table) in the linked list should have items: prev, next, value
4. add brief description to what each function is meant to do and adjust params if neccessary.
5. add logic outline for each function
6. implement each function logic
7. test and fix
8. submit
9. read other solutions
10. improve and optimize
11. resubmit
]]
