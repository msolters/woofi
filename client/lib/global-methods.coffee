@getNamePart = (part=0) ->
  try
    return unless Meteor.userId()
    nameParts = Meteor.user().profile.name.split ' '
    nameParts[part]

@handleMethodResponse = (err, resp, successMsg=null, errorMsg=null) ->
  if err?
    if errorMessage?
      Materialize.toast errorMsg, 4500, "red"
    else
      Materialize.toast err, 4500, "red"
  else
    if resp.success is true
      if successMsg?
        if typeof successMsg is 'object'
          Materialize.toast successMsg[0], 5000, successMsg[1]
        else
          Materialize.toast successMsg, 5000, "green"
      else
        Materialize.toast resp.msg, 5000, "green"
    else
      Materialize.toast resp.msg, 4500, "red"
