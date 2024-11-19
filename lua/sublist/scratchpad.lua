local tests = {
  { pat = "ABA", text = "ABAAAABAACD" },
  { pat = "PAN", text = "ANPANMAN" },
  { pat = "NNAAMAN", text = "ANPANMANAM" },
  { pat = "ANAMPNAM", text = "MANPANAMANAP" },
  { pat = "TEST", text = "THIS IS A TEST TEXT" },
  { pat = "AABA", text = "AABAACAADAABAABA" },
  { pat = "TATGTG", text = "GCAATGCCTATGTGACC" },
  { pat = "CABAB", text = "ABAABABACBA" },
  { pat = "ABBAB", text = "ABAABABACBA" },
  { pat = "CBAAB", text = "AACABABACBA" },
  { pat = "AACCACCAC", text = "AABABABACBACABBCAB" },
}
for _, test in ipairs(tests) do
  print(("pattern: '%s' , text: '%s'"):format(test.pat, test.text))
  for _, version in ipairs {
    "./sublist-tears.lua",
    "./sublist.lua",
    "./sublist-kmp.lua",
    "./sublist-linear.lua",
  } do
    local module = dofile(version)
    local pat, text = {}, {}
    test.pat:gsub(".", function(c) pat[#pat + 1] = c end)
    test.text:gsub(".", function(c) text[#text + 1] = c end)
    local _, offsets = module(pat, text)
    print(("%-20s : count-%i : "):format(version, #offsets), unpack(offsets))
  end
end
