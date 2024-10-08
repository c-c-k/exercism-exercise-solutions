local DNA = {}

function DNA:new(sequence)
  assert(not sequence:find "[^ATCG]", "Invalid Sequence")
  local nucleotideCounts = {
    A = 0,
    T = 0,
    C = 0,
    G = 0,
  }

  for nucleotide in sequence:gmatch "." do
    nucleotideCounts[nucleotide] = nucleotideCounts[nucleotide] + 1
  end

  return {
    count = function(_, nucleotide)
      assert(nucleotideCounts[nucleotide], "Invalid Nucleotide")
      return nucleotideCounts[nucleotide]
    end,
    nucleotideCounts = nucleotideCounts,
  }
end

return DNA
