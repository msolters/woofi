Template.registerHelper "urlIs", (_url) ->
  if _url is window.location.pathname
    return "active"
  return ""
