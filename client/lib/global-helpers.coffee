Template.registerHelper 'routeIs', (_route) ->
  return true if _route is FlowRouter.getRouteName()
  return false

Template.registerHelper 'convertRSSItoPercent', (dBm) ->
  Math.min( Math.max(2 * (dBm + 100), 0), 100)
