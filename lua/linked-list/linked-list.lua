-- NOTE: The behavior for poping/shifting an empty linkedlist
-- is not tested or specified so the behavior follows
-- Lua's behavior for table.remove({}) (i.e. return nil)

local function push(linkedlist, value)
  local node = { value = value }

  if linkedlist._count == 0 then
    linkedlist._head = node
  else
    node.prev = linkedlist._tail
    linkedlist._tail.next = node
  end

  linkedlist._tail = node
  linkedlist._count = linkedlist._count + 1
end

local function pop(linkedlist)
  local count = linkedlist._count
  if count == 0 then return end

  local node = linkedlist._tail

  if count == 1 then
    linkedlist._head = nil
  else
    node.prev.next = nil
  end

  linkedlist._tail = node.prev
  linkedlist._count = count - 1

  return node.value
end

local function unshift(linkedlist, value)
  local node = { value = value }

  if linkedlist._count == 0 then
    linkedlist._tail = node
  else
    node.next = linkedlist._head
    linkedlist._head.prev = node
  end

  linkedlist._head = node
  linkedlist._count = linkedlist._count + 1
end

local function shift(linkedlist)
  local count = linkedlist._count
  if count == 0 then return end

  local node = linkedlist._head

  if count == 1 then
    linkedlist._tail = nil
  else
    node.next.prev = nil
  end

  linkedlist._head = node.next
  linkedlist._count = count - 1

  return node.value
end

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
