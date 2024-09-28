local TwoFer = {}

function TwoFer.two_fer(name)
  return ('One for %s, one for me.'):format(name or 'you')
end

return TwoFer
