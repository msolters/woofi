###
#     Template.internalSideNav
###
Template.internalSideNav.created = ->
  @subscribe "Feeders"

Template.internalSideNav.rendered = ->
  @sideNavTrigger = $ @find '.button-collapse'
    .sideNav()

Template.internalSideNav.helpers
  feeders: ->
    Feeders.find().fetch()
  routeContext: ->
    _routeName = FlowRouter.getRouteName()
    switch _routeName
      when "Feeder Console"
        feeder_q =
          feeder_id: FlowRouter.getParam 'feeder_id'
        feeder = Feeders.findOne feeder_q
        feeder.name if feeder?
      else
        _routeName
  feederIsSelected: (_feeder_id) ->
    if FlowRouter.getRouteName() is "Feeder Console"
      feeder_id = FlowRouter.getParam 'feeder_id'
      if feeder_id is _feeder_id
        return true
    return false

Template.internalSideNav.events
  'click .side-nav a': ->
    $('.button-collapse').sideNav 'hide'
  'click a[data-sign-out]': ->
    AccountsTemplates.logout()
