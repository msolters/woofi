Template.registerHelper 'routeIs', (_route) ->
  return true if _route is FlowRouter.getRouteName()
  return false

Template.registerHelper 'routeContext', ->
  _routeName = FlowRouter.getRouteName()
  switch _routeName
    when "Feeder Console"
      feeder_q =
        sn: FlowRouter.getParam 'sn'
      feeder = Feeders.findOne feeder_q
      feeder.name if feeder?
    when 'Welcome'
      'Vet Innovations'
    when 'atSignIn'
      'Sign In'
    when 'atSignUp'
      'Register'
    else
      _routeName

Template.registerHelper 'convertRSSItoPercent', (dBm) ->
  Math.min( Math.max(2 * (dBm + 100), 0), 100)

Template.registerHelper 'getNamePart', (part=0) ->
  getNamePart part

Template.registerHelper 'myFeeders', ->
  Feeders.find().fetch()
