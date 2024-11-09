local function _sort_grade(grade, sorted_grades)
  if not sorted_grades[grade] then
    table.sort(grade)
    sorted_grades[grade] = true
  end
end
local School = {}

School.__index = School

function School:new()
  return setmetatable(
    { _grades = {}, _sorted_grades = {}, _students = {} },
    self
  )
end

function School:add(student, grade)
  -- NOTE: this input check is not checked in tests but required in the exercise spec
  if self._students[student] then
    error(
      ("Student %s already registered in grade %s"):format(
        student,
        self._students[student]
      )
    )
  end

  self._students[student] = grade
  if not self._grades[grade] then self._grades[grade] = {} end
  table.insert(self._grades[grade], student)
  self._sorted_grades[grade] = nil
end

function School:grade(grade)
  if not self._grades[grade] then return {} end

  _sort_grade(self._grades[grade], self._sorted_grades)
  return self._grades[grade]
end

function School:roster()
  for _, grade in pairs(self._grades) do
    _sort_grade(grade, self._sorted_grades)
  end

  return self._grades
end

return School
