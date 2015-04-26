@unitTriggers =
  mass: new Deps.Dependency

@handleMethodReply = (error, reply, options={}) ->
  if error?
    Materialize.toast error, 4000, "red"
  else
    if reply.success is true
      if options.success?
        Materialize.toast options.success, 4000, "light-green"
      else
        Materialize.toast reply.msg, 4000, "light-green"
    else
      Materialize.toast reply.msg, 4000, "red"

@isInput = (keyCode) ->
  if keyCode is 8 or keyCode is 46 or keyCode is 13 #backspace, delete, enter are valid reasons to trigger input event
    return true
  if alphaNumericKeys.test String.fromCharCode keyCode
    return true
  else
    return false

###
#     Unit-specific Methods:
###
# Takes M in kilos to whatever the user's preferred unit is
@convertMassToPreference = (M) ->
  if Meteor.user().profile.units.mass is "lb"
    return accounting.formatNumber M*2.20462, 2  # convert kilos to pounds
  return accounting.formatNumber M, 2 # otherwise, return kilograms
# Takes M in user's preferred unit to kilos
@convertMassToKilos = (M) ->
  if Meteor.user().profile.units.mass is "lb"
    return accounting.formatNumber M/2.20462, 2  # convert pounds to kilos
  return accounting.formatNumber M, 2 #otherwise, M is already in kilos
