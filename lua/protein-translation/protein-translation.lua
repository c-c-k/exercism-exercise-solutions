local CODON_MAP = {}

local f = io.open("./codon_to_protein_map.txt", "r")
if f then
  for codons, protein in f:read("*a"):gmatch "| (%u%u%u.-) | (%w+)%s+|" do
    for codon in codons:gmatch "%u%u%u" do
      CODON_MAP[codon] = protein
    end
  end
  f:close()
else
  error "Can't find codon_to_protein_map.txt"
end

local function translate_codon(codon)
  return CODON_MAP[codon]
      or error(('Illegal Codon: "%s"'):format(tostring(codon)), 2)
end

local function translate_rna_strand(rna_strand)
  local proteins = {}

  for codon in rna_strand:gmatch "..." do
    local success, result = pcall(translate_codon, codon)
    if not success then error(result, 2) end
    if result == "STOP" then break end
    table.insert(proteins, result)
  end

  return proteins
end

return { codon = translate_codon, rna_strand = translate_rna_strand }
