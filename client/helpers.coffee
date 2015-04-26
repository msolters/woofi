Template.registerHelper "urlIs", (_url) ->
  if _url is Router.current().location.get().path
    return "active"
  return ""
