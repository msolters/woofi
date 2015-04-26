Template.registerHelper "urlIs", ->
  _url = ""
  if arguments.length >= 1
    for n in [0..arguments.length-2]
      _url += arguments[n]
    if _url is Router.current().location.get().path
      return "active"
  return ""
