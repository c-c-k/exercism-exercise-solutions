local DiffSqr = {}

function DiffSqr.square_of_sum(n)
  return (n * (n + 1) / 2) ^ 2
end

function DiffSqr.sum_of_squares(n)
  return n * (n + 1) * (2 * n + 1) / 6
end

function DiffSqr.difference_of_squares(n)
  return DiffSqr.square_of_sum(n) - DiffSqr.sum_of_squares(n)
end

return DiffSqr
