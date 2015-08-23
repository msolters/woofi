###
#     Template.internalSideNav
###
Template.internalSideNav.rendered = ->
  @sideNavTrigger = $ @find '.button-collapse'
    .sideNav()

###
Template.internalSideNav.events
  'click .side-nav a': (event, template) ->
    template.sideNavTrigger.sideNav 'hide'
###
