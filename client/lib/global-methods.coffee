@handleMethodReply = (error, reply) ->
  if error?
    toast error, 4000, "red"
  else
    if reply.success is true
      Materialize.toast reply.msg, 4000, "light-green"
    else
      Materialize.toast reply.msg, 4000, "red"
