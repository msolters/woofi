###
#     Template.internalSideNav
###
Template.internalSideNav.created = ->
  @subscribe "Feeders"

Template.internalSideNav.rendered = ->
  @sideNavTrigger = $ @find '.button-collapse'
    .sideNav()
  $ @find '.dropdown-button'
    .dropdown
      constrain_width: false
      alignment: 'right'
      belowOrigin: true

Template.internalSideNav.helpers
  feeders: ->
    Feeders.find().fetch()
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
  'click a[data-edit-profile]': ->
    AntiModals.overlay 'editProfile'
