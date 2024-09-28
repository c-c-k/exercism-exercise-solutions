local bob = {}

function bob.hey(say)
  local reply = 'Whatever'

  local is_silence = not say:match '%S'
  local is_shout = not say:match '%l'
  local is_question = say:match '%?$'

  if is_silence then
    reply = 'Fine, be that way.'
  elseif is_shout and is_question then
    reply = "Calm down, I know what I'm doing!"
  elseif is_question then
    reply = 'Sure'
  elseif is_shout then
    reply = 'Whoa, chill out!'
  end

  return reply
end

return bob
