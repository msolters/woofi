Template.registerHelper "urlIs", ->
  _url = ""
  if arguments.length >= 1
    for n in [0..arguments.length-2]
      _url += arguments[n]
    if _url is Router.current().location.get().path
      return "active"
  return ""

Template.registerHelper "firstName", ->
  if Meteor.user()
    return Meteor.user().profile.name.split(' ')[0]

Template.registerHelper "isActive", (val) ->
  if val?
    return "active"
Template.registerHelper "isValid", (val) ->
  if val?
    return "valid"
Template.registerHelper "isActiveOption", (val, checkAgainst) ->
  if val is checkAgainst
    return "selected"
