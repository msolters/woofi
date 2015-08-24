Template.registerHelper 'routeIs', (_route) ->
  return true if _route is FlowRouter.getRouteName()
  return false
