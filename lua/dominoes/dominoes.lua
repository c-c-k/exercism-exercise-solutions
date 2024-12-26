local function get_dominoes_with_count(dominoes)
  local dominoes_with_count = {}
  local domino_id_to_index = {}

  for _, domino in ipairs(dominoes) do
    local face1, face2 = domino[1], domino[2]
    if face1 > face2 then
      face1, face2 = face2, face1
    end

    local domino_id = 10 * face1 + face2
    local index = domino_id_to_index[domino_id]
    if index then
      dominoes_with_count[index].count = dominoes_with_count[index].count + 1
    else
      table.insert(
        dominoes_with_count,
        { face1 = face1, face2 = face2, count = 1 }
      )
      domino_id_to_index[domino_id] = #dominoes_with_count
    end
  end

  return dominoes_with_count
end

local function get_dominoes_by_face(dominoes)
  local dominoes_with_count = get_dominoes_with_count(dominoes)
  local dominoes_by_face = {}

  for _, domino in ipairs(dominoes_with_count) do
    local face1, face2 = domino.face1, domino.face2
    if not dominoes_by_face[face1] then dominoes_by_face[face1] = {} end
    table.insert(dominoes_by_face[face1], domino)
    if face1 ~= face2 then
      if not dominoes_by_face[face2] then dominoes_by_face[face2] = {} end
      table.insert(dominoes_by_face[face2], domino)
    end
  end

  return dominoes_by_face
end

local function check_subchain(
    total_unused,
    dominoes_by_face,
    left_face,
    right_face
)
  if total_unused == 0 then return left_face == right_face end

  for _, domino in ipairs(dominoes_by_face[left_face]) do
    if domino.count > 0 then
      domino.count = domino.count - 1
      if
          check_subchain(
            total_unused - 1,
            dominoes_by_face,
            left_face ~= domino.face1 and domino.face1 or domino.face2,
            right_face
          )
      then
        return true
      end
      domino.count = domino.count + 1
    end
  end

  return false
end

local function is_circular_chain(total_unused, dominoes_by_face)
  for _, dominoes_list in ipairs(dominoes_by_face) do
    for _, domino in ipairs(dominoes_list) do
      domino.count = domino.count - 1
      if
          check_subchain(
            total_unused - 1,
            dominoes_by_face,
            domino.face1,
            domino.face2
          )
      then
        return true
      end
      domino.count = domino.count + 1
    end
  end

  return false
end

local function can_chain(dominoes)
  local total_unused = #dominoes
  if total_unused == 0 then return true end

  local dominoes_by_face = get_dominoes_by_face(dominoes)

  return is_circular_chain(total_unused, dominoes_by_face)
end

return { can_chain = can_chain }
