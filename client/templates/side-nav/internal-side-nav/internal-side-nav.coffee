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
          sn: FlowRouter.getParam 'sn'
        feeder = Feeders.findOne feeder_q
        feeder.name if feeder?
      else
        _routeName
  feederIsSelected: (_sn) ->
    if FlowRouter.getRouteName() is "Feeder Console"
      sn = FlowRouter.getParam 'sn'
      if sn is _sn
        return true
    return false

Template.internalSideNav.events
  'click .side-nav a': ->
    $('.button-collapse').sideNav 'hide'
  'click a[data-sign-out]': ->
    AccountsTemplates.logout()
