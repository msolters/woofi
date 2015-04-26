@handleMethodReply = (error, reply) ->
  if error?
    Materialize.toast error, 4000, "red"
  else
    if reply.success is true
      Materialize.toast reply.msg, 4000, "light-green"
    else
      Materialize.toast reply.msg, 4000, "red"

@isInput = (keyCode) ->
  if keyCode is 8 or keyCode is 46 #backspace, delete are valid reasons to trigger input event
    return true
  if alphaNumericKeys.test String.fromCharCode keyCode
    return true
  else
    return false
