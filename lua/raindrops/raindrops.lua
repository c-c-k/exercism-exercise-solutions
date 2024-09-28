local iao_map = { [3] = 'i', [5] = 'a', [7] = 'o' }
return function(n)
  local output = ''
  for divisor = 3, 7, 2 do
    if n % divisor == 0 then
      output = ('%sPl%sng'):format(output, iao_map[divisor])
    end
  end
  return output ~= '' and output or tostring(n)
end
