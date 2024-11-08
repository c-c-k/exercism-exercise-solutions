return function(s) return s:gsub("(%w)%u*[^%u -]*[ -]?", "%1"):upper() end
