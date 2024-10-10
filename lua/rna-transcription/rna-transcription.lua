return function(dna)
  return dna:gsub(".", { C = "G", G = "C", A = "U", T = "A" })
end
