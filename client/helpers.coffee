###
#     User & Preferences
###
Template.registerHelper "firstName", ->
  if Meteor.user()
    return Meteor.user().profile.name.split(' ')[0]
Template.registerHelper "convertMassToPreference", (M) ->
  return convertMassToPreference M

###
#     Routing
###
Template.registerHelper "urlIs", ->
  _url = ""
  if arguments.length >= 1
    for n in [0..arguments.length-2]
      _url += arguments[n]
    if _url is Router.current().location.get().path
      return "active"
  return ""

###
#     Forms & Input
###
Template.registerHelper "isActive", (val) ->
  if val?
    return "active"
Template.registerHelper "isValid", (val, email=false) ->
  if email is true
    if validateEmail.test val
      return "valid"
  else
    if val?
      return "valid"
Template.registerHelper "isActiveOption", (val, checkAgainst) ->
  if val is checkAgainst
    return "selected"
#  Returns a reasonable min or max for a given pet.type
Template.registerHelper "massExtrema", (minOrMax, petType) ->
  # (1) First we get the requested value in kilograms:
  switch petType
    when "dog"
      switch minOrMax
        when "min"
          val = 0
        when "max"
          val = 45
    when "cat"
      switch minOrMax
        when "min"
          val = 0
        when "max"
          val = 20
  # (2) Next, we return it in the user's preferred unit
  return convertMassToPreference val
